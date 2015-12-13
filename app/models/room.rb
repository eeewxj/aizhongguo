class Room < ActiveRecord::Base
  belongs_to :zone, inverse_of: :rooms
  has_many :residents, inverse_of: :room
end
