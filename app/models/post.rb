class Post < ActiveRecord::Base
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy
  validates :title, presence: true

  def content_preview
    content[0..75] + '...' unless content.empty?
  end
end
