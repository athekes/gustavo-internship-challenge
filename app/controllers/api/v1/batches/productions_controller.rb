class Api::V1::Batches::ProductionsController < ApplicationController
  def update
    @batch = Batch.joins(:orders).find_by(reference: params[:reference])
    @batch.orders.update_all(status: 'production')

    render json: { reference: @batch.reference, status: 'production' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    head 404
  end
end
