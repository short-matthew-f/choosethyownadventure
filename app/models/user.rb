class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_one :profile, dependent: :destroy
  has_one :avatar, through: :profile, source: :avatar
  
  delegate :name, to: :profile
  
  has_many :histories, dependent: :destroy
  has_many :played_mazes, through: :histories, source: :maze
  
  has_many :ratings, inverse_of: :user, dependent: :destroy
  
  has_many :mazes, foreign_key: :author_id, dependent: :destroy
  
  def is_playing?(maze)
    relevant_history = self.histories.find_by(maze_id: maze.id)
    
    return false unless relevant_history
    
    relevant_history.room_id != nil
  end
  
  def has_finished?(maze)
    relevant_history = self.histories.find_by(maze_id: maze.id)
    
    return false unless relevant_history
    
    (relevant_history.win_count + relevant_history.loss_count) > 0
  end
  
  def has_rated?(maze)
    !!self.ratings.find_by(maze_id: maze.id)
  end
end
