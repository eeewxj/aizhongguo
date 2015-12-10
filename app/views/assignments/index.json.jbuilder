json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :user_id, :resident_id, :project_id
  json.url assignment_url(assignment, format: :json)
end
