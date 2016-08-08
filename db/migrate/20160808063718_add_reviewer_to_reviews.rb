class AddReviewerToReviews < ActiveRecord::Migration
  def change
    add_reference :reviews, :reviewer, index:true
    add_foreign_key :reviews, :users, column: :reviewer_id
  end
end
