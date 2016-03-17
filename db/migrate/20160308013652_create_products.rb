class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :color
      t.integer :price
      t.string :material
      t.string :where_made

      t.timestamps null: false
    end
  end
end
