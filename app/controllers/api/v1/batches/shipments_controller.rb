class Api::V1::Batches::ShipmentsController < ApplicationController
  def update
    reference = params[:reference]
    delivery_service = shipments_params[:delivery_service]

    batch = Batch.find_by(reference: reference)
    raise ActiveRecord::RecordNotFound if batch.nil?

    orders = batch.orders.where(delivery_service: delivery_service)
    raise ActiveRecord::RecordNotFound if orders.empty?

    orders.update(status: 'sent')

    render json: {
      reference: batch.reference,
      delivery_service: delivery_service,
      status: 'sent',
      orders_count: orders.count
    }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable batch or orders for a batch" }, status: :not_found
  end

  private

  def shipments_params
    params.require(:options).permit(:delivery_service)
  end
end
