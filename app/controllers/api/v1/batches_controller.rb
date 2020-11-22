class Api::V1::BatchesController < ApplicationController
  def show
    batch = Batch.joins(:orders).find_by(reference: params[:reference])

    options = {}
    options[:include] = [:orders]
    render json: BatchSerializer.new(batch, options).serializable_hash.to_json, status: :ok
  end

  def create
    orders_for_batch = Order.where(purchase_channel: params[:purchase_channel], batch: nil)
    raise ActiveRecord::RecordNotFound if orders_for_batch.nil? || orders_for_batch.empty?

    batch = Batch.new(batch_params)

    if batch.save
      orders_for_batch.update_all(batch_id: batch.id)
      render json: { reference: batch.reference, order_count: batch.orders.count }, status: :created
    else
      render json: batch.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    head 404
  end

  private

  def batch_params
    params.require(:batch).permit(:purchase_channel)
  end
end
