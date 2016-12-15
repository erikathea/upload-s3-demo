class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  CONTENT_TYPE = ['image/jpeg', 'image/jpg', 'image/gif', 'image/png']
  IMAGE_SIZE = 5.megabytes

  has_attached_file :image
  validates_attachment_content_type :image,
                                    :content_type => CONTENT_TYPE,
                                    :message      => 'has to be in a proper format'
  validates_attachment_size :image, :less_than => IMAGE_SIZE
  validates_attachment_presence :image

  def name
    return image_file_name if image_file_name.length <= 25

    image_file_name[0..20] + '...' + image_file_name[-4..-1]
  end
end
