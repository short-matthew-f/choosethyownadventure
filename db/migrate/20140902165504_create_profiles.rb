class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      
      t.string :name
      t.string :location
      
      t.date :birthdate 
      
      t.text :biography
      
      t.boolean :visible, null: false, default: false

      t.timestamps
    end
    
    add_index :profiles, :user_id, unique: true
  end
end
