class RemoveTypeFromPlace < ActiveRecord::Migration
  def change
    remove_column :places, :type, :string
  end
end
