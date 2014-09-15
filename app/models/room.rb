class Room < ActiveRecord::Base  
  # associations
  belongs_to :maze
  delegate :author, to: :maze
  
  has_many :exits, class_name: Hallway, foreign_key: :entrance_id, dependent: :destroy, inverse_of: :entrance
  has_many :entrances, class_name: Hallway, foreign_key: :exit_id, dependent: :destroy, inverse_of: :exit
  
  has_many :next_rooms, through: :exits, source: :exit
  has_many :previous_rooms, through: :entrances, source: :entrance
  
  # paperclip polymorphic
  has_one :picture, as: :imageable, dependent: :destroy
  
  # validations
  validates :name, :description, :maze, presence: true
  
  validate :start_or_end
  validate :win_or_lose
  validate :only_one_start
  
  def start_or_end
    if self.start && (self.win || self.lose)
      errors.add(:start, "room cannot be the final room.")
    end
  end
  
  def win_or_lose
    if self.win && self.lose
      errors.add(:win, "or lose, please choose only one.")
    end
  end
  
  def only_one_start
    start_rooms = self.maze.rooms.where(start: true)
        
    if start_rooms.count > 1 && self.start == true
      errors.add(:start, "room already exists.  Please change #{start_rooms.first.name}, or uncheck start here for this room.")
    end
  end
end
