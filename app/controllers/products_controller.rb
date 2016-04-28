class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show, :run_search]

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
    elsif params[:category]
      @products = Category.find_by(name: params[:category]).products
    end
    if current_user
      @carted_products = CartedProduct.where("user_id = ? AND status = ?", current_user.id.to_i, "carted") 
    end
  end

  def show
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    if current_user
      @carted_products = CartedProduct.where("user_id = ? AND status = ?", current_user.id.to_i, "carted")
    end
  end

  def new
    @product = Product.new
    @suppliers = Supplier.all
  end

  def create
    @product = Product.new(
      title: params[:title],
      color: params[:color],
      material: params[:material],
      where_made: params[:where_made],
      price: params[:price],
      description: params[:description],
      supplier_id: params[:supplier][:supplier_id]
    )
    if @product.save      
      @image = Image.new(image_url: params[:image_url], product_id: @product.id)
      if @image.save       
        flash[:success] = "Product successfully created!"
        redirect_to "/products/#{@product.id}"
      else
        render "new.html.erb"
      end
    else
      render "new.html.erb"
    end    
  end

  def edit
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    @carted_products = CartedProduct.where("user_id = ? AND status = ?", current_user.id.to_i, "carted")     
  end

  def update
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    @product.update(
      title: params[:title],
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

  private

  def authenticate_admin!
    unless current_user && current_user.admin
      redirect_to "/"
    end
  end
end