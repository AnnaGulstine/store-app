class CartedProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  belongs_to :user

  validates :status, presence: true

  validates :status, inclusion: { in: %w(carted, removed, purchased), message: "%{value} is not a valid input." }

  def count
    CartedProduct.where(status: 'carted').count
  end
end
