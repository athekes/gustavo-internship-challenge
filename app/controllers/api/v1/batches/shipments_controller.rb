class Api::V1::Batches::ShipmentsController < ApplicationController
  def update
    batch = find_batch(params[:reference])
    orders = find_avaliable_orders(shipments_params[:delivery_service], batch)

    orders.update(status: 'sent')

    render_response(batch, orders, shipments_params[:delivery_service])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable batch or orders for a batch" }, status: :not_found
  end

  private

  def shipments_params
    params.require(:options).permit(:delivery_service)
  end

  def find_batch(reference)
    batch = Batch.find_by(reference: reference)
    raise ActiveRecord::RecordNotFound if batch.nil?

    batch
  end

  def find_avaliable_orders(delivery_service, batch)
    orders = batch.orders.where(delivery_service: delivery_service)
    raise ActiveRecord::RecordNotFound if orders.empty?

    orders
  end

  def render_response(batch, orders, delivery_service)
    render json: {
      reference: batch.reference,
      delivery_service: delivery_service,
      status: 'sent',
      orders_count: orders.count
    }, status: :ok
  end
end
