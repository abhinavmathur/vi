class AddImagesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :product_images, :text
  end
end
