class Maze < ActiveRecord::Base
  # user associations
  belongs_to :author, class_name: User
  
  has_many :players, through: :histories, source: :user
  has_many :histories
  
  has_many :ratings, inverse_of: :maze
  
  # maze associations
  has_many :rooms, dependent: :destroy, inverse_of: :maze
  has_many :hallways, through: :rooms, source: :exits
  
  # paperclip polymorphic
  has_one :picture, as: :imageable, dependent: :destroy
  
  # validations
  validates :title, :description, presence: true
  
  validate :connected_if_published
  validate :solvable_if_published
  
  def is_connected?
    disconnected_rooms.none?
  end
  
  def disconnected_rooms
    current_room = self.start_room
    return nil unless current_room
    
    rooms_left = self.rooms - [current_room]
    
    rooms_to_traverse = []
    
    while current_room && rooms_left.any?
      puts current_room
      
      next_rooms = current_room.next_rooms
      
      rooms_to_traverse.concat(next_rooms)
      rooms_left -= next_rooms
      
      current_room = rooms_to_traverse.shift
    end
    
    rooms_left 
  end
  
  def start_room
    rooms = self.rooms.where(start: true)
    
    if rooms.any? && rooms.count == 1
      return rooms.first
    else
      return nil
    end
  end
  
  def has_ending?
    self.rooms.where('win=? OR lose=?', true, true).any?
  end
  
  def connected_if_published
    if self.published && !self.is_connected?
      errors.add(:published, "is not valid with isolated rooms.")
    end
  end
  
  def solvable_if_published
    if self.published && self.is_connected? && !self.has_ending?
      errors.add(:published, "is not valid with no way to end the maze.")
    end
  end
end
