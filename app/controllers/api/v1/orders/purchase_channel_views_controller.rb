class Api::V1::Orders::PurchaseChannelViewsController < ApplicationController
  def index
    purchase_channel = params[:purchase_channel]
    status = params[:status]

    @orders = if status.nil?
                Order.where(purchase_channel: purchase_channel)
              else
                Order.where(purchase_channel: purchase_channel, status: status)
              end

    render json: OrderSerializer.new(@orders).serializable_hash.to_json, status: :ok
  rescue ActiveRecord::RecordNotFound
    head 404
  end
end
