class Api::V1::Orders::OrdersWithStatusController < ApplicationController
  def show
    reference = params[:reference]
    client_name = params[:client_name]

    @orders = get_orders(reference, client_name)

    render json: hash_orders_status(@orders), status: :ok
  rescue ActiveRecord::RecordNotFound
    head 404
  end

  private

  def hash_orders_status(orders)
    hash_orders = []
    orders.each do |order|
      hash_orders << { reference: order.reference, status: order.status }
    end
    hash_orders
  end

  def get_orders(reference, client_name)
    if reference
      Order.where(reference: reference)
    elsif client_name
      Order.where(client_name: client_name)
    end
  end
end
