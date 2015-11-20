json.array!(@notifications) do |notification|
  json.extract! notification, :id, :text, :estado, :user_id
  json.url notification_url(notification, format: :json)
end
