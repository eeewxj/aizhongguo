json.array!(@records) do |record|
  json.extract! record, :id, :user_id, :resident_id, :project_id, :desc
  json.url record_url(record, format: :json)
end
