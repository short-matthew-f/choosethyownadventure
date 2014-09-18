class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :maze
  
  validates :user, :maze, :stars, :description, presence: true
  
  validates_inclusion_of :stars, in: (1..5) 
end
