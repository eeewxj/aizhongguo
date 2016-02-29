json.array!(@nursings) do |nursing|
  json.extract! nursing, :id, :nurse_id, :resident_id
  json.url nursing_url(nursing, format: :json)
end
