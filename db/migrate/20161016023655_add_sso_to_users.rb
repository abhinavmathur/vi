class AddSsoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sso, :string, default: ''
  end
end
