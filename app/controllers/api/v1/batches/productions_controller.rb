class Api::V1::Batches::ProductionsController < ApplicationController
  def update
    batch = find_batch(params[:reference])

    orders = batch.orders
    orders.update(status: 'production')

    render json: { reference: batch.reference, status: 'production' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable batch" }, status: :not_found
  end

  def find_batch(reference)
    batch = Batch.includes(:orders).find_by(reference: reference)
    raise ActiveRecord::RecordNotFound if batch.nil?

    batch
  end
end
