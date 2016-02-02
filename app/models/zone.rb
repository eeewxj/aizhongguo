class Zone < ActiveRecord::Base
  belongs_to :nursing_home
  has_many :rooms
  has_many :residents, through: :rooms
end
