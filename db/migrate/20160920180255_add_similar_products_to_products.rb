class AddSimilarProductsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :similar_products, :text
  end
end
