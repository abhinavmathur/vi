class AddAffiliateCategoryToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :affiliate_category, :boolean, default: false
  end
end
