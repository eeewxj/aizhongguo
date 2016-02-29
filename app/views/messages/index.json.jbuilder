json.array!(@messages) do |message|
  json.extract! message, :id, :sender_id, :user_id, :content, :status
  json.url message_url(message, format: :json)
end
