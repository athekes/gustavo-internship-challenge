class Api::V1::Orders::OrdersWithStatusController < ApplicationController
  def show
    reference = order_with_status_params[:reference]
    client_name = order_with_status_params[:client_name]

    orders = get_client_orders(reference, client_name)
    render json: { orders: orders_status_array(orders) }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable orders" }, status: :not_found
  end

  private

  def order_with_status_params
    params.require(:orders).permit(:client_name, :reference)
  end

  def orders_status_array(orders)
    orders_array = []
    orders.each do |order|
      orders_array << { reference: order.reference, status: order.status }
    end
    orders_array
  end

  def get_client_orders(reference, client_name)
    if reference
      orders = Order.where(reference: reference)
    elsif client_name
      orders = Order.where(client_name: client_name).reverse_order.limit(10)
    end
    raise ActiveRecord::RecordNotFound if orders.empty?

    orders
  end
end
