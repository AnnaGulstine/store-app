class Product < ActiveRecord::Base
  belongs_to :supplier
  has_many :images
  has_many :carted_products
  has_many :orders, through: :carted_products
  has_many :categorized_products
  has_many :categories, through: :categorized_products

  validates :title, presence: true
  validates :title, uniqueness: true

  validates :price, presence: true
  validates :price, numericality: true
  validates :price, :numericality => { :greater_than => 0 }

  validates :supplier_id, presence: true

  def friendly_updated_at
    updated_at.strftime("%A, %d %b %Y %l:%M %p")
  end

  def sale_message
    if price < 2
      message = "Discount Item!"
    else
      message = "On Sale!"
    end
  end

  def tax
    tax = price * 0.09
  end

  def total
    price + tax
  end

  def is_in_stock
    if in_stock == true
      message = "In stock"
    else
      message = "Out of stock"
    end
  end
end