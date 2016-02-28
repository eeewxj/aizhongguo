class Project < ActiveRecord::Base
#活动报名截止时间为活动前一天晚上十点 project.start_at.beginning_of_day.ago(7200)

  belongs_to :nursing_home
  has_many :pickup_sites
  has_many :applications
  has_many :assignments,  dependent: :destroy
  has_many :records
  has_many :attended_applications, -> {where verified: true, attended: true}, class_name: "Application"
  has_many :volunteers, through: :attended_applications, source: :user
  belongs_to :contact, class_name: "User", foreign_key: "contact_id"
  accepts_nested_attributes_for :pickup_sites

#活动状态定义（针对活动本身而言）
#1、尚未开始报名。活动虽然被已经被创建但是还没有对外发布，默认两周以内开始的活动为可以报名活动，
#超过两周以后才开始的活动只会被管理员看到。
#2、已经开始报名但尚未进行。对用户而言分为已经报名和尚未报名。
#3、报名已经结束，但尚未进行。对用户而言只有已经报名一个状态，如果未报名，看不到此类活动。
#4、正在进行。只有已经报名的用户才能看到。
#5、已经结束，即往期活动。对用户而言分为参加过的活动和未参加过的活动。
#注意：某个活动对于用户而言的状态都在User model中定义，例如已经报名的活动、参加过的活动等。
  scope :draft,      -> { where("start_at > ?", Time.now+14.days) }
#  scope :published
#  scope :upcoming
  scope :ongoing,    -> { where("start_at < ? AND end_at > ?", Time.now, Time.now) }
  scope :finished,   -> { where("end_at < ?", Time.now) }

#已经开始报名但尚未进行的活动
  def self.published
    if Time.now < Time.now.end_of_day.ago(7199)
      where("start_at > ? AND start_at < ?", Time.now.end_of_day, (Time.now+14.days))
    else
      where("start_at > ? AND start_at < ?", (Time.now.end_of_day+1.day), (Time.now+14.days))
    end
  end
#报名已经结束，但尚未进行的活动
  def self.upcoming
    if Time.now < Time.now.end_of_day.ago(7199)
      where("start_at > ? AND start_at < ?", Time.now, Time.now.end_of_day)
    else
      where("start_at > ? AND start_at < ?", Time.now, Time.now.end_of_day+1.day)
    end
  end

  def reg_deadline
    start_at.beginning_of_day.ago(7200)
  end



end
