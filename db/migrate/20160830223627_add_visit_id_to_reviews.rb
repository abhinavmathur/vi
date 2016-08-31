class AddVisitIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :visit_id, :integer
  end
end
