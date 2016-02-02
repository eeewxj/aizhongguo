class Room < ActiveRecord::Base
  belongs_to :zone
  has_many :residents
end
