json.array!(@residents) do |resident|
  json.extract! resident, :id, :name, :gender, :birthday, :home_address, :condition, :phone_number, :contact, :contact_phone_number
  json.url resident_url(resident, format: :json)
end
