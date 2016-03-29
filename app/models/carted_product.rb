class CartedProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  belongs_to :user

  def count
    CartedProduct.where(status: 'carted').count
  end
end
