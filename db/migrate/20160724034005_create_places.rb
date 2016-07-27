class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name, default: "", null: false
      t.string :address, default: ""
      t.float :lat
      t.float :lon
      t.string :full_address, default: ""
      t.string :type, default: ""
      t.integer :owner
      t.boolean :confirmed, default: false
      t.timestamps null: false
    end

    add_index(:places, :name)
  end
end
