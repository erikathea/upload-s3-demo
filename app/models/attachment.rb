class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  FILE_SIZE = 10.megabytes

  has_attached_file :file
  validates_attachment_size :file, :less_than => FILE_SIZE
  validates_attachment_presence :file

  # Note: https://github.com/thoughtbot/paperclip/issues/1771
  # For the meantime, skip validation of file_type
  do_not_validate_attachment_file_type :file
end
