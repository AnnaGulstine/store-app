class OrdersController < ApplicationController
  def create
    order = Order.create(
      quantity: params[:quantity],
      user_id: current_user.id
    )
    redirect_to "/orders/#{order.id}"
  end

  def show
    render 'show.html.erb'
  end
end