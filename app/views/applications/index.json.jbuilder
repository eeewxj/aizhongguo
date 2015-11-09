json.array!(@applications) do |application|
  json.extract! application, :id, :project_id, :user_id, :verified, :attended
  json.url application_url(application, format: :json)
end
