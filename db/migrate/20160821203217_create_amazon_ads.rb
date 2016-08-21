class CreateAmazonAds < ActiveRecord::Migration
  def change
    create_table :amazon_ads do |t|
      t.belongs_to :review
      t.string :title
      t.string :link_id
      t.string :asins
      t.timestamps null: false
    end
  end
end
