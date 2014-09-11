class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :maze_id, null: false
      
      t.string :name, null: false
      t.text :description, null: false
      
      t.boolean :start, default: false
      t.boolean :win, default: false
      t.boolean :lose, default: false

      t.timestamps
    end
    
    add_index :rooms, :maze_id
  end
end
