json.array!(@residents) do |resident|
  json.extract! resident, :id, :name, :gender, :birthday, :condition, :phone_number, :contact, :contact_phone_number, :room_id
  json.url resident_url(resident, format: :json)
end
