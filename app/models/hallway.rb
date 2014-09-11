class Hallway < ActiveRecord::Base
  validates :entrance, :exit, :description, presence: true
  
  belongs_to :entrance, class_name: Room, foreign_key: :entrance_id
  belongs_to :exit, class_name: Room, foreign_key: :exit_id
end
