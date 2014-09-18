class Profile < ActiveRecord::Base
  belongs_to :user
  
  validates :name, :location, presence: true
  
  has_attached_file :avatar, styles: {
    original: "200x200#",
    thumb: "50x50#"
  }, default_url: ActionController::Base.helpers.asset_url('avatar.png')
  
  validates_attachment_content_type(
    :avatar,
    content_type: /\Aimage\/.*\Z/
  )
end
