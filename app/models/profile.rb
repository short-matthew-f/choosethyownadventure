class Profile < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :avatar, styles: {
    original: "200x200#",
    thumb: "50x50#"
  }, default_url: ActionController::Base.helpers.asset_path('avatar.png')
  
  validates_attachment_content_type(
    :avatar,
    content_type: /\Aimage\/.*\Z/
  )
end
