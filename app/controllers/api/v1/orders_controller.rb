class Api::V1::OrdersController < ApplicationController

  def status
    reference = params[:reference]
    client_name = params[:client_name]

    if !reference.nil?
      @orders = Order.where(reference: reference)
    elsif !client_name.nil?
      @orders = Order.where(client_name: client_name)
    end

    response_orders = []
    @orders.each do |order|
      response_orders << { reference: order.reference, status: order.status }
    end

    render json: response_orders, status: :ok
  end

  def orders_by_purchase_channel
    purchase_channel = params[:purchase_channel]
    status = params[:status]

    @orders = if status.nil?
                Order.where(purchase_channel: purchase_channel)
              else
                Order.where(purchase_channel: purchase_channel).where(status: status)
              end

    render json: OrderSerializer.new(@orders).serializable_hash.to_json, status: :ok
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      render json: OrderSerializer.new(@order).serializable_hash.to_json, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
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
      line_items: %i[sku model case_type color]
    )
  end
end
