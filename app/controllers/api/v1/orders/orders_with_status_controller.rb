class Api::V1::Orders::OrdersWithStatusController < ApplicationController
  def show
    reference = order_with_status_params[:reference]
    client_name = order_with_status_params[:client_name]

    orders = get_client_orders(reference, client_name)
    raise ActiveRecord::RecordNotFound if orders.nil? || orders.empty?

    render json: { orders: orders_status_hash(orders) }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable orders" }, status: :not_found
  end

  private

  def order_with_status_params
    params.require(:orders).permit(:client_name, :reference)
  end

  def orders_status_hash(orders)
    orders_hash = []
    orders.each do |order|
      orders_hash << { reference: order.reference, status: order.status }
    end
    orders_hash
  end

  def get_client_orders(reference, client_name)
    if reference
      Order.where(reference: reference)
    elsif client_name
      Order.where(client_name: client_name).reverse_order.limit(10)
    end
  end
end
