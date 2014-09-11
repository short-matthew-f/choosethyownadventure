class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :imageable, polymorphic: true, null: false

      t.timestamps
    end
    
    add_attachment :pictures, :image
  end
end
