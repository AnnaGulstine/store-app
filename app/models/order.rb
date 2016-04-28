class Order < ActiveRecord::Base
  belongs_to :user
  has_many :carted_products
  has_many :products, through: :carted_products

  validates :user_id, presence: true

  validates :subtotal, presence: true
  validates :tax, presence: true
  validates :total, presence: true
  
  validates :subtotal, numericality: true
  validates :tax, numericality: true
  validates :total, numericality: true

  def friendly_created_at
    created_at.strftime("%A, %d %b %Y %l:%M %p")    
  end
end
