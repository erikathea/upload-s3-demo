class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :image, { preserve_files: true }
  validates_attachment_content_type :image,
                                    :content_type => ['image/jpeg', 'image/pjpeg',
                                                      'image/jpg', 'image/png', 'image/tif',
                                                      'image/tiff', 'image/gif'],
                                    :message      => 'has to be in a proper format'
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_presence :image
end
