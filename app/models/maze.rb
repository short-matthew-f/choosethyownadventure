class Maze < ActiveRecord::Base
  # user associations
  belongs_to :author, class_name: User
  
  has_many :histories, dependent: :destroy
  has_many :players, through: :histories, source: :user
  
  has_many :ratings, inverse_of: :maze, dependent: :destroy
  
  # maze associations
  has_many :rooms, dependent: :destroy, inverse_of: :maze
  accepts_nested_attributes_for :rooms
  
  has_many :hallways, through: :rooms, source: :exits
  
  # paperclip polymorphic
  has_one :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture
  
  delegate :image, to: :picture
  
  # validations
  validates :title, :description, presence: true
  
  validate :connected_if_published
  validate :solvable_if_published
  validate :no_dead_ends_if_published
  
  # scopes
  
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  
  def total_wins
    self.histories.map(&:win_count).inject(:+)
  end
  
  def total_losses
    self.histories.map(&:loss_count).inject(:+)
  end
  
  def average_rating
    all_ratings = self.ratings
    
    if all_ratings.count > 0
      (all_ratings.map(&:stars).inject(:+).to_f / all_ratings.count).round(1)
    else
      0
    end
  end
  
  def is_connected?
    disconnected_rooms.nil? || disconnected_rooms.none?
  end
  
  def disconnected_rooms
    current_room = self.start_room
    
    return nil unless current_room
    
    rooms_left = self.rooms - [current_room]
    
    rooms_to_traverse = []
    
    while current_room && rooms_left.any?
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
  
  def dead_ends
    middle_rooms = self.rooms.where('win=? AND lose=?', false, false)
    
    middle_rooms.select do |room|
      room.next_rooms.none?
    end
  end
  
  def has_dead_ends?
    self.dead_ends.any?
  end
  
  def connected_if_published
    if self.published && !self.is_connected?
      errors.add(:published, :disconnected)
    end
  end
  
  def solvable_if_published
    if self.published && self.is_connected? && !self.has_ending?
      errors.add(:published, :unsolvable)
    end
  end
  
  def no_dead_ends_if_published
    if self.published && self.has_dead_ends?
      errors.add(:published, :dead_ends)
    end
  end
end
