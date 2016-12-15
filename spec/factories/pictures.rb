FactoryGirl.define do
  factory :picture do
    association :imageable, factory: :post
    stamp 'random-12345'

    after(:build) do |pic|
      pic.image_file_name = 'img.png'
      pic.image_file_size = '1000'
      pic.image_content_type = 'image/png'
      pic.image_updated_at = Date.today
    end
  end
end