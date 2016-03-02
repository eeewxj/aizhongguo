class Assignment < ActiveRecord::Base
  belongs_to :project
  belongs_to :zone
  belongs_to :user
end
