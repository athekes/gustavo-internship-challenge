class Api::V1::Batches::ClosingsController < ApplicationController
  def update
    @batch = Batch.joins(:orders).find_by(reference: params[:reference])
    @batch.orders.update_all(status: 'closing')

    render json: { reference: @batch.reference, status: 'closing' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    head 404
  end
end
