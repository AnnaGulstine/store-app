class Image < ActiveRecord::Base
  belongs_to :product

  def create
    image = Image.create(
      image_url: params[:image_url],
      product_id: params[:product_id],
      front_page: params[:front_page]
    )
  end
end