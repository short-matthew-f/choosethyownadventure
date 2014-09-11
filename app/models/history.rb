class History < ActiveRecord::Base
  
  validates :user_id, :maze_id, presence: true
  
  belongs_to :user
  belongs_to :maze
  
  def abandon_maze!
    self.room_id = nil
    self.loss_count += 1
    
    self.save!
  end
end
