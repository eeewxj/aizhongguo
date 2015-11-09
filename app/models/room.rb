class Room < ActiveRecord::Base
  belongs_to :nursing_home, inverse_of: :rooms
  has_many :residents, inverse_of: :room
end
