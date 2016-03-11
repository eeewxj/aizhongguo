class NursingHome < ActiveRecord::Base

  has_many :managements, dependent: :destroy
  has_many :directors, through: :managements, source: :user
  has_many :zones, dependent: :destroy
  has_many :rooms, through: :zones
  has_many :residents, through: :rooms
  has_many :projects
  has_many :records, through: :projects
  has_many :nurses
  has_many :nursings, through: :nurses
end
