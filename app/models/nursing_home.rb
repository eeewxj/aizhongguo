class NursingHome < ActiveRecord::Base

  has_many :managements, dependent: :destroy
  has_many :directors, through: :managements, source: :user
  has_many :zones, dependent: :destroy, inverse_of: :nursing_home
  has_many :rooms, through: :zones
  has_many :residents, through: :rooms
  has_many :projects, inverse_of: :nursing_home

end
