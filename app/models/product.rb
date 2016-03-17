class Product < ActiveRecord::Base
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