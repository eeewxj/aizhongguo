class Zone < ActiveRecord::Base
  belongs_to :nursing_home, inverse_of: :zones
  has_many :rooms, inverse_of: :zone
end
