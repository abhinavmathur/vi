class AddGooglePlusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_plus, :string
  end
end
