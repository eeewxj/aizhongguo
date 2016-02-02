class Project < ActiveRecord::Base
#活动报名截止时间为活动前一天晚上十点 project.start_at.beginning_of_day.ago(7200)

  belongs_to :nursing_home
  has_many :pickup_sites
  has_many :applications
  has_many :assignments,  dependent: :destroy
  has_many :records
  has_many :attended_applications, -> {where verified: true, attended: true}, class_name: "application"
  has_many :volunteers, through: :attended_applications, source: :user
  belongs_to :contact, class_name: "User", foreign_key: "contact_id"
  accepts_nested_attributes_for :pickup_sites


  def reg_deadline
    start_at.beginning_of_day.ago(7200)
  end

end
