class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, index: true, default: ""
      t.text :description
      t.references :category, index: true, foreign_key: true
      t.string :company
      t.string :tags
      t.string :asin
      t.string :slug
      t.boolean :adult, default: false
      t.timestamps null: false
    end
  end
end
