class Api::V1::OrdersController < ApplicationController
  def show
    reference = params[:reference]
    order = find_order(reference)

    render json: OrderSerializer.new(order).serializable_hash.to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable order" }, status: :not_found
  end

  def create
    order = Order.new(order_params)

    if order.save
      render json: OrderSerializer.new(order).serializable_hash.to_json, status: :created
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :reference,
      :purchase_channel,
      :client_name,
      :address,
      :delivery_service,
      :status,
      :total_value_cents,
      line_items: %i[sku model case_type color]
    )
  end

  def find_order(reference)
    order = Order.find_by(reference: reference)
    raise ActiveRecord::RecordNotFound if order.nil?

    order
  end
end
