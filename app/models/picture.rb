class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  
  # paperclip
  has_attached_file :picture, styles: { original: "150x150#" }
  validates_attachment_content_type( :picture, content_type: /\Aimage\/.*\Z/ )
end
