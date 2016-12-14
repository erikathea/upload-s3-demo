json.extract! picture, :id, :image, :imageable_id, :imageable_type, :created_at, :updated_at
json.url picture.image_url(picture, format: :json)