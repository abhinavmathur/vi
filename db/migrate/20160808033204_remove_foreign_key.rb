class RemoveForeignKey < ActiveRecord::Migration
  def change
    remove_foreign_key('products', 'category')
  end
end
