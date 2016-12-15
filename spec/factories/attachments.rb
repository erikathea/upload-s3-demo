FactoryGirl.define do
  factory :attachment do
    association :attachable, factory: :post
    stamp 'random-12345'

    after(:build) do |file|
      file.file_file_name = 'img.png'
      file.file_file_size = 1024
      file.file_content_type = 'application/pdf'
      file.file_updated_at = Date.today
    end

  end
end