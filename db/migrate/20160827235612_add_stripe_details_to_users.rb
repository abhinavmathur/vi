class AddStripeDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :card_last4, :string
    add_column :users, :card_exp_month, :string
    add_column :users, :card_exp_year, :string
    add_column :users, :card_brand, :string
  end
end
