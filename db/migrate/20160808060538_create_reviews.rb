class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title, index: true
      t.text :description
      t.string :tags
      t.string :youtube_url
      t.string :other_video_url
      t.string :affiliate_tag
      t.string :affiliate_link
      t.boolean :has_youtube_link, default: false
      t.integer :reviewfiable_id
      t.string :reviewfiable_type
      t.boolean :publish
      t.string :slug


      t.timestamps null: false
    end

    add_index :reviews, [:reviewfiable_id, :reviewfiable_type]
  end
end
