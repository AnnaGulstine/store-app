class AddProductIdColumnToImages < ActiveRecord::Migration
  def change
    add_column :images, :product_id, :string
  end
end
