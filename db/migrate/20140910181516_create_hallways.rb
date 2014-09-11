class CreateHallways < ActiveRecord::Migration
  def change
    create_table :hallways do |t|
      t.integer :entrance_id, null: false
      t.integer :exit_id, null: false
      
      t.string :description, null: false

      t.timestamps
    end
    
    add_index :hallways, :entrance_id
    add_index :hallways, :exit_id
    add_index :hallways, [:entrance_id, :exit_id], unique: true
  end
end
