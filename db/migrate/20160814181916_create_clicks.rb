class CreateClicks < ActiveRecord::Migration
  def change
    create_table :clicks do |t|
      t.integer :review_id, index: true
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
