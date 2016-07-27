class AddCategoryNumberToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :category_number, :integer
  end
end
