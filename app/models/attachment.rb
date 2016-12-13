class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  has_attached_file :file
  do_not_validate_attachment_file_type :file
  validates_attachment_size :file, :less_than => 10.megabytes
end
