class CreateMazes < ActiveRecord::Migration
  def change
    create_table :mazes do |t|
      t.integer :author_id, null: false
      t.string :title, null: false
      t.text :description, null: false
      
      t.boolean :published, default: false

      t.timestamps
    end
    
    add_index :mazes, :author_id
  end
end
