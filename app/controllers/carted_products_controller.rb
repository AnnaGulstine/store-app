class CartedProductsController < ApplicationController
  def index
    if current_user
      @carted_products = CartedProduct.where("user_id = ? AND status = ?", current_user.id.to_i, "carted")
      if @carted_products.length == 0
        redirect_to '/products'
      end
    else
      redirect_to '/'
    end
  end

  def create
    if current_user
      CartedProduct.create(
        user_id: current_user.id,
        product_id: params[:product_id],
        quantity: params[:quantity],
        status: "carted"
      )
      redirect_to "/carted_products"
    else
      flash[:success] = "Please sign in to purchase products."      
      redirect_to '/users/sign_in'
    end
  end

  def destroy
    carted_product = CartedProduct.find_by(id: params[:id])
    carted_product.update(status: "removed")
    flash[:success] = "Product Successfully Removed from Cart"
    redirect_to "/carted_products"
  end
end