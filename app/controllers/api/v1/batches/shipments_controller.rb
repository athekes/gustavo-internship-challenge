class Api::V1::Batches::ShipmentsController < ApplicationController
  def update
    reference = params[:reference]
    delivery_service = params[:options][:delivery_service] if params[:options]

    batch = Batch.joins(:orders).find_by(reference: reference)
    raise ActiveRecord::RecordNotFound if batch.nil?

    orders = batch.orders.where(delivery_service: delivery_service)
    raise ActiveRecord::RecordNotFound if orders.nil? || orders.empty?

    orders.update_all(status: 'sent')

    render json: {
      reference: batch.reference,
      delivery_service: delivery_service,
      status: 'sent',
      orders_count: orders.count
    }, status: :ok

  rescue ActiveRecord::RecordNotFound
    head 404
  end
end
