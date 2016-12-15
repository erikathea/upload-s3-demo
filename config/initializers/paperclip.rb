module Paperclip::Interpolations
  # Note: MonkeyPatched - used in displaying s3 uploaded files
  def stamp(attachment, style_name)
    attachment.instance.stamp
  end
end

Paperclip::Attachment.default_options.merge!(
  url:            ':s3_domain_url',
  path:           'uploads/:stamp/:filename', # ':class/:attachment/:id/:style/:filename',
  storage:        :s3,
  s3_credentials: Rails.configuration.aws,
  s3_region:      Rails.configuration.aws[:region],
  s3_permissions: :private,
  s3_protocol:    'https'
)
