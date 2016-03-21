class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  def friendly_created_at
    created_at.strftime("%A, %d %b %Y %l:%M %p")    
  end
end
