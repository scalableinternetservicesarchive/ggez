json.extract! user, :id, :username, :industry, :created_at, :updated_at
json.url user_url(user, format: :json)
