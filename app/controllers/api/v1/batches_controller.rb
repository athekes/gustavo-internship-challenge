class Api::V1::BatchesController < ApplicationController
  def index
    batches = Batch.all
    render json: BatchSerializer.new(batches).serializable_hash.to_json, status: :ok
  end

  def show
    batch = find_batch(params[:reference])

    options = {}
    options[:include] = [:orders]
    render json: BatchSerializer.new(batch, options).serializable_hash.to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable batch" }, status: :not_found
  end

  def create
    batch_orders = find_batch_orders(batch_params[:purchase_channel])

    batch = Batch.new(batch_params)

    if batch.save
      batch_orders.update(batch_id: batch.id)
      render json: { reference: batch.reference, order_count: batch.orders.count }, status: :created
    else
      render json: batch.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable orders" }, status: :not_found
  end

  private

  def batch_params
    params.require(:batch).permit(:purchase_channel)
  end

  def find_batch(reference)
    batch = Batch.includes(:orders).find_by(reference: reference)
    raise ActiveRecord::RecordNotFound if batch.nil?

    batch
  end

  def find_batch_orders(purchase_channel)
    orders = Order.where(purchase_channel: purchase_channel, batch: nil)
    raise ActiveRecord::RecordNotFound if orders.empty?

    orders
  end
end
