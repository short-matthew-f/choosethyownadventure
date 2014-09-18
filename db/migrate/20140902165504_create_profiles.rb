class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      
      t.string :name, null: false
      t.string :location, null: false
      
      t.text :biography
      
      t.timestamps
    end
    
    add_index :profiles, :user_id, unique: true
  end
end
