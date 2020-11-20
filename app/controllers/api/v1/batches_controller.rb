class Api::V1::BatchesController < ApplicationController
  def create
    @batch = Batch.new(batch_params)

    if @batch.save
      orders_for_batch = Order.where(batch: nil).where(purchase_channel: params[:purchase_channel])

      orders_for_batch.each do |order|
        order.update(batch: @batch)
      end

      render json: { reference: @batch.reference, order_count: @batch.orders.count }, status: :created
    else
      render json: @batch.errors, status: :unprocessable_entity
    end
  end

  def show
    @batch = Batch.find_by(reference: params[:reference])

    options = {}
    options[:include] = [:orders]
    render json: BatchSerializer.new(@batch, options).serializable_hash.to_json, status: :ok
  end

  def produce
    @batch = Batch.includes(:orders).find_by(reference: params[:reference])

    @batch.orders.each do |order|
      order.update(status: 'production')
    end

    render json: { reference: @batch.reference, status: 'production' }, status: :ok
  end

  def closing
    @batch = Batch.includes(:orders).find_by(reference: params[:reference])

    @batch.orders.each do |order|
      order.update(status: 'closing')
    end

    render json: { reference: @batch.reference, status: 'closing' }, status: :ok
  end

  def sent
    @batch = Batch.includes(:orders).find_by(reference: params[:reference])

    @batch.orders.each do |order|
      order.update(status: 'sent')
    end

    render json: { reference: @batch.reference, status: 'sent' }, status: :ok
  end

  private

  def batch_params
    params.require(:batch).permit(:reference, :purchase_channel)
  end
end
