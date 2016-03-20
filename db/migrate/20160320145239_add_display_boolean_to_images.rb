class AddDisplayBooleanToImages < ActiveRecord::Migration
  def change
    add_column :images, :front_page, :boolean
  end
end
