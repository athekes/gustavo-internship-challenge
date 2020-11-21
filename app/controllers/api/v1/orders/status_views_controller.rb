class Api::V1::Orders::StatusViewsController < ApplicationController
  def show
    reference = params[:reference]
    client_name = params[:client_name]

    if reference
      @orders = Order.where(reference: reference)
    elsif client_name
      @orders = Order.where(client_name: client_name)
    end

    orders = []
    @orders.each do |order|
      orders << { reference: order.reference, status: order.status }
    end

    render json: orders, status: :ok
  rescue ActiveRecord::RecordNotFound
    head 404
  end
end
