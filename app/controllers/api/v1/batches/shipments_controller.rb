class Api::V1::Batches::ShipmentsController < ApplicationController
  def update
    @batch = Batch.joins(:orders).find_by(reference: params[:reference])
    @batch.orders.update_all(status: 'sent')

    render json: { reference: @batch.reference, status: 'sent' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    head 404
  end
end
