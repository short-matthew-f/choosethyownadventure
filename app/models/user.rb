class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_one :profile
  has_one :avatar, through: :profile, source: :avatar
  
  has_many :histories
  has_many :played_mazes, through: :histories, source: :maze
  
  has_many :ratings, inverse_of: :user
  
  has_many :mazes, foreign_key: :author_id, dependent: :destroy
  
end
