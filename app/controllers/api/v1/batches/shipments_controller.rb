class Api::V1::Batches::ShipmentsController < ApplicationController
  def update
    reference = params[:reference]
    delivery_service = params[:delivery_service]

    @batch = Batch.joins(:orders).find_by(reference: params[:reference])
    if delivery_service
      @batch.orders.where(delivery_service: delivery_service).update_all(status: 'sent')
    elsif reference
      @batch.orders.update_all(status: 'sent').update_all(status: 'sent')
    end
    render json: { reference: @batch.reference, status: 'sent' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    head 404
  end
end
