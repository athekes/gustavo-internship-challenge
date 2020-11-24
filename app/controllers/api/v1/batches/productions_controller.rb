class Api::V1::Batches::ProductionsController < ApplicationController
  def update
    batch = Batch.includes(:orders).find_by(reference: params[:reference])
    raise ActiveRecord::RecordNotFound if batch.nil?

    orders = batch.orders
    orders.update(status: 'production')

    render json: { reference: batch.reference, status: 'production' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable batch" }, status: :not_found
  end
end
