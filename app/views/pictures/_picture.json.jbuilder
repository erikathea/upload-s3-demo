json.extract! picture, :id, :image, :imageable_id, :imageable_type, :created_at, :updated_at
json.url picture_url(picture, format: :json)