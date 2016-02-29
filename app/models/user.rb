class User < ActiveRecord::Base
##常量定义##
#定义用户类型
  TYPE_ADMIN = 0 #超级管理员
  TYPE_DIRECTOR = 1 #组长，管理单个养老院
  TYPE_VOLUNTEER = 2 #志愿者，权限最低
#定义用户头像的小图和中图最大宽高
  AVATAR_SW = 100
  AVATAR_SH = 100
  AVATAR_NW = 300
  AVATAR_NH = 300
##可用参数##
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

##模型关系##
#for the admin user_type==0

#for directors user_type==1
  has_one :management, dependent: :destroy
  has_one :nursing_home, through: :management
#for volunteers user_type==2
  has_many :applications, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :records
  has_many :attended_applications, -> {where(verified: true, attended: true)}, class_name: "Application"
  has_many :attended_projects, through: :attended_applications, source: :project
  has_many :absent_applications, -> {where(verified: true, attended: false)}, class_name: "Application"
  has_many :absent_projects, through: :absent_applications, source: :project
  has_many :sent_messages, :foreign_key => "sender_id", :class_name => "Message"
  has_many :received_messages, :class_name => "Message"


##数据验证##
  #binding.pry
  validates :email, :presence => { :message => '亲，邮箱可不能为空' },
            :uniqueness =>{:message => "亲，这个邮箱已经注册过了" },
            :format => { :with => /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-z]+\Z/, :message => "您这是邮箱吗?" }
  validates :password, :presence => { :message => '亲，密码可不能为空' },
            :length => { :in => 6..32, :too_short => '不要这么短哦', :too_long  => '不要这么长哦'},
            :confirmation => {:message => '亲，要一样哦'}
  validates :phone_number, :presence => { :message => '电话一定要填的' }






  has_attached_file :avatar,
    :default_url => "/images/default_avatar.png", 
    :hash_secret => "efb40e6f2783c6d6641db8f1accdce15", 
    :styles => { :medium => "#{AVATAR_NW}x#{AVATAR_NH}>", :thumb => "#{AVATAR_SW}x#{AVATAR_SH}>" },
    :processors => [:jcropper],
    :dependent => :destroy
  validates_attachment :avatar,
    :content_type => { :content_type => /\Aimage\/.*\Z/ },
    :size => { :in => 0..4096.kilobytes }

##公共方法##

#是否有要求的裁剪参数  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

#裁剪时获取图片原始尺寸
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file avatar.path(style)
  end

#注册邮箱查重
  def self.check_email_available(checked_email)
    self.where("email = '#{checked_email}'").empty?
  end
#用户登录验证
  def self.authenticate(email, password)
    user = find_by_email(email)
    (user && user.password == password)? user : nil
  end

#是否管理员
  def admin?
    user_type==TYPE_ADMIN
  end
#是否组长
  def director?
    user_type==TYPE_DIRECTOR
  end
#是否志愿者
  def volunteer?
    user_type==TYPE_VOLUNTEER
  end

#设置为志愿者后清理管理关系
  def clean_management
    Management.find_by_user_id(id).destroy
  end

#查询是否已经申请某个活动
  def has_applied?(project)
    Application.where(user_id: id, project_id: project.id).any?
  end

#返回对某个活动的申请
  def application_of(project)
    Application.where(user_id: id, project_id: project.id)[0]
  end
#可以报名的活动(包括已经报名和尚未报名的活动)，即Project.published
  def regable_projects
    Project.published
  end
#已经报名、报名结束、尚未开始的活动,即user参加的Project.upcoming
  def upcoming_projects
    Project.upcoming.joins(:applications).where(applications: {user_id: id, verified: true})
  end

#已经报名、报名结束、正在进行的活动,即user参加的Project.ongoing
  def ongoing_projects
    Project.ongoing.joins(:applications).where(applications: {user_id: id, verified: true, attended: true})
  end

#已经报名、已经完成、尚未填写关怀记录的活动
  def unfinished_projects
    #NOT EXISTS 和 LEFT JOIN WHERE IS NULL能达到同样的效果，后者运行速度更快
    #Project.finished.joins(:applications).where(applications: {user_id: id, verified: true, attended: true}).where("NOT EXISTS (select * from records where records.user_id = applications.user_id AND records.project_id = applications.project_id)")

    Project.finished.joins(:applications).where(applications: {user_id: id, verified: true, attended: true}).joins("LEFT JOIN records on records.user_id = applications.user_id AND records.project_id = applications.project_id").where("records.user_id IS NULL")

  end
#已经报名，已经参加，已经填写了关怀记录的活动
  def finished_projects
    Project.finished.joins(:applications).where(applications: {user_id: id, verified: true, attended: true}).joins("JOIN records on records.user_id = applications.user_id AND records.project_id = applications.project_id")
  end
#已经完成，但是尚处在修改期的活动
  def modifiable_projects
    finished_projects.where("end_at > ?", Time.now-3.days)
  end
end
