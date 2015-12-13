json.array!(@zones) do |zone|
  json.extract! zone, :id, :name, :nursing_home_id, :description
  json.url zone_url(zone, format: :json)
end
