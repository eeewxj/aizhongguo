json.array!(@rooms) do |room|
  json.extract! room, :id, :room_number, :description, :nursing_home_id
  json.url room_url(room, format: :json)
end
