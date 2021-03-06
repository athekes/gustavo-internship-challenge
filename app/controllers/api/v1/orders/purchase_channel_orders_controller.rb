class Api::V1::Orders::PurchaseChannelOrdersController < ApplicationController
  def index
    purchase_channel = purchase_channel_orders_params[:purchase_channel]
    status = purchase_channel_orders_params[:status]

    orders = get_purchase_channel_orders(purchase_channel, status)
    render json: OrderSerializer.new(orders).serializable_hash.to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Can't find avaliable orders" }, status: :not_found
  end

  private

  def purchase_channel_orders_params
    params.require(:orders).permit(:purchase_channel, :status)
  end

  def get_purchase_channel_orders(purchase_channel, status)
    if purchase_channel && status
      orders = Order.where(purchase_channel: purchase_channel, status: status)
    elsif purchase_channel
      orders = Order.where(purchase_channel: purchase_channel)
    end
    raise ActiveRecord::RecordNotFound if orders.empty?

    orders
  end
end
