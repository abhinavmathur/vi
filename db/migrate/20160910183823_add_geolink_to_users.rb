class AddGeolinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country_code, :string
    add_column :users, :affiliate_countries, :string
  end
end
