json.extract! album, :id, :name, :artist, :description, :created_at, :updated_at
json.url album_url(album, format: :json)
