class CartedProductsController < ApplicationController
  def index
    @carted_products = CartedProduct.where("user_id = ? AND status = ?", current_user.id.to_i, "carted")
    if CartedProduct.where(status: "carted").count == 0
      redirect_to '/products'
    end
  end

  def create
    CartedProduct.create(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted"
    )
    redirect_to "/carted_products"
  end
end