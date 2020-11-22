class Api::V1::Orders::PurchaseChannelOrdersController < ApplicationController
  def index
    purchase_channel = params[:purchase_channel]
    status = params[:status]

    @orders = get_orders(purchase_channel, status)

    render json: OrderSerializer.new(@orders).serializable_hash.to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    head 404
  end

  private

  def get_orders(purchase_channel, status)
    if purchase_channel && status
      Order.where(purchase_channel: purchase_channel, status: status)
    elsif purchase_channel
      Order.where(purchase_channel: purchase_channel)
    end
  end
end
