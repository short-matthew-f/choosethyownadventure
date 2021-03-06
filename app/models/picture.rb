class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  
  # paperclip
  has_attached_file :image, 
    styles: { original: "150x150#" },
    default_url: 'missing.jpg'
    
  validates_attachment_content_type( :image, content_type: /\Aimage\/.*\Z/ )
end
