class Nurse < ActiveRecord::Base
  belongs_to :nursing_home
  has_many :nursings, dependent: :destroy
  has_many :residents, through: :nursings
end
