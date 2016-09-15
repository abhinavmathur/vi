class AddTargetCountriesToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :target_countries, :string
  end
end
