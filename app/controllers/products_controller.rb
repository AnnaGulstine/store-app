class ProductsController < ApplicationController

  def index
    @products = Product.all 
    sort_by = params[:sort_by]
    sort_order = params[:sort_order]
    if sort_by
      @products = Product.order(sort_by => sort_order)
    elsif params["discount"]
      @products = Product.where('price < ?', 20)
    elsif params["random_item"]
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
      title: params[:title],
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
      title: params[:title],
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

  def run_search
    search_term = params[:search]
    @products = Product.where('description LIKE ?', "%" + search_term + "%")
    render 'index.html.erb'
  end
end