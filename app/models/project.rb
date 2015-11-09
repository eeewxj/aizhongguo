class Project < ActiveRecord::Base
  belongs_to :nursing_home
  has_many :applications
  has_many :attended_applications, -> {where verified: true, attended: true}, class_name: "application"
  has_many :volunteers, through: :attended_applications, source: :user
  belongs_to :contact, class_name: "User", foreign_key: "contact_id"
end
