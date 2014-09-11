class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :maze_id, null: false
      t.integer :user_id, null: false
      
      t.integer :stars, null: false
      t.text :description

      t.timestamps
    end
    
    add_index :ratings, :maze_id
    add_index :ratings, :user_id
    
    add_index :ratings, [:maze_id, :user_id], unique: true
  end
end
