class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :reviewer_id, index: true
      t.integer :points, default: 0

      t.timestamps null: false
    end
  end
end
