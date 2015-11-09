json.array!(@managements) do |management|
  json.extract! management, :id, :nursing_home_id, :user_id
  json.url management_url(management, format: :json)
end
