class Api::V1::Batches::ShipmentsController < ApplicationController
  def update
    reference = params[:reference]
    delivery_service = params[:delivery_service]

    batch = Batch.joins(:orders).find_by(reference: reference)
    raise ActiveRecord::RecordNotFound if batch.nil?

    orders = set_orders_to_sent(batch, delivery_service)
    orders.update_all(status: 'sent')

    render json: { reference: batch.reference, status: 'sent' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    head 404
  end

  private

  def set_orders_to_sent(batch, delivery_service)
    if delivery_service
      batch.orders.where(delivery_service: delivery_service)
    else
      batch.orders
    end
  end
end
