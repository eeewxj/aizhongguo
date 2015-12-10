class Resident < ActiveRecord::Base
  belongs_to :room, -> { includes :nursing_home}, inverse_of: :residents
  has_many :records
end
