class Supplier < ActiveRecord::Base
  has_many :products
  
  def create
    supplier = Supplier.create(
      name: params[:name],
      email: params[:email],
      phone: params[:phone]
    )
  end
end
