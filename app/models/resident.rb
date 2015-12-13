class Resident < ActiveRecord::Base
  belongs_to :room, inverse_of: :residents
  has_many :records
end
