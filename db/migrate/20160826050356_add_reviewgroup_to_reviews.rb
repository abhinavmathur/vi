class AddReviewgroupToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :reviewgroup_id, :integer
  end
end
