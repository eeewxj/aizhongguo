json.array!(@projects) do |project|
  json.extract! project, :id, :name, :nursing_home_id, :description, :start_at, :end_at, :staff_number, :contact_id
  json.url project_url(project, format: :json)
end
