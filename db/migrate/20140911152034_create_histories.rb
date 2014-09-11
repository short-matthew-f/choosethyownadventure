class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :user_id, null: false
      t.integer :maze_id, null: false
      t.integer :room_id
      
      t.integer :win_count, default: 0
      t.integer :loss_count, default: 0

      t.timestamps
    end
    
    add_index :histories, :user_id
    add_index :histories, :maze_id
    add_index :histories, [:user_id, :maze_id], unique: true
  end
end
