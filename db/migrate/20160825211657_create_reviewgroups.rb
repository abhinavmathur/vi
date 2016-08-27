class CreateReviewgroups < ActiveRecord::Migration
  def change
    create_table :reviewgroups do |t|
      t.string :title
      t.string :short_description
      t.integer :category_id, index: true
      t.integer :user_id, index:true
      t.string :slug

      t.timestamps null: false
    end
  end
end
