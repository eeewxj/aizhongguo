class Nursing < ActiveRecord::Base
  belongs_to :nurse
  belongs_to :resident
end
