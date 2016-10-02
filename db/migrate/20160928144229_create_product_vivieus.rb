class CreateProductVivieus < ActiveRecord::Migration
  def change
    create_table :product_vivieus do |t|

      t.timestamps null: false
    end
  end
end
