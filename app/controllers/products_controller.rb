class ProductsController < ApplicationController
  def index
    @products = Product.all 
    sort_attribute = params[:sort]
    sort_order = params[:sort_order]
    discount_items = params[:discount]
    random_item = params[:random]
    if sort_attribute
      @products = Product.order(sort_attribute => sort_order)
    elsif discount_items
      @products = Product.where('price < ?', 20)
    elsif random_item
      @product = Product.order('RANDOM()').first
    end
  end

  def show
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    render "show.html.erb"
  end

  def new
    render 'new.html.erb'
  end

  def create
    product = Product.create(
      image: params[:image],
      color: params[:color],
      material: params[:material],
      where_made: params[:where_made],
      price: params[:price],
      description: params[:description]
    )
    product_id = params[:id]
    @product = Product.find_by(id: product_id)    
    product = Product.last
    flash[:success] = "Product successfully created!"
    redirect_to "/products/#{product.id}"
  end

  def edit
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    render 'edit.html.erb'
  end

  def update
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    @product.update(
      image: params[:image],
      color: params[:color],
      material: params[:material],
      where_made: params[:where_made],
      price: params[:price],
      description: params[:description]
    )
    flash[:success] = "Product successfully updated!"
    redirect_to "/products/#{@product.id}"
  end

  def destroy
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    @product.destroy
    flash[:success] = "Product successfully deleted!"  
    redirect_to '/products'
  end
end