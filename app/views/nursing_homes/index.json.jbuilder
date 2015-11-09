json.array!(@nursing_homes) do |nursing_home|
  json.extract! nursing_home, :id, :name, :address, :contact, :phone_number, :description, :website
  json.url nursing_home_url(nursing_home, format: :json)
end
