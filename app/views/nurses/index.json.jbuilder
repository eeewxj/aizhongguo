json.array!(@nurses) do |nurse|
  json.extract! nurse, :id, :name, :birthday, :gender, :phone, :hometown, :home, :education, :previous_job, :religion, :interests, :background, :nursing, :nursing_home_id
  json.url nurse_url(nurse, format: :json)
end
