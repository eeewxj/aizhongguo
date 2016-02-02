json.array!(@pickup_sites) do |pickup_site|
  json.extract! pickup_site, :id, :name, :project_id, :liaison, :phone_number, :meeting_time
  json.url pickup_site_url(pickup_site, format: :json)
end
