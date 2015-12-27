class Record < ActiveRecord::Base
  belongs_to :resident, inverse_of: :records
  belongs_to :project, -> { includes :nursing_home }, inverse_of: :records
  belongs_to :user, inverse_of: :records
end
