class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :image
  validates_attachment_content_type :image,
                                    :content_type => ['image/jpeg', 'image/ppg',
                                                      'image/gif', 'image/png'],
                                    :message      => 'has to be in a proper format'
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_presence :image

  def s3_key
    "uploads/#{stamp}/#{image_file_name}"
  end

  def s3_obj
    S3_BUCKET.object(key)
  end
end
