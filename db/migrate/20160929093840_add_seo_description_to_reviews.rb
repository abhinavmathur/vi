class AddSeoDescriptionToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :seo_description, :string
  end
end
