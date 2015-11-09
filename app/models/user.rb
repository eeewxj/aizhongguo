class User < ActiveRecord::Base
#for the admin user_type==0

#for directors user_type==1
  has_one :management, dependent: :destroy
  has_one :nursing_home, through: :management
#for volunteers user_type==2
  has_many :applications, dependent: :destroy
  has_many :attended_applications, -> {where verified: true, attended: true}, class_name: "application"
  has_many :attended_projects, through: :attended_applications, source: :project
  has_many :absent_applications, -> {where verified: true, attended: false}, class_name: "application"
  has_many :absent_projects, through: :absent_applications, source: :project

  #binding.pry
  validates :email, :presence => { :message => '亲，邮箱可不能为空' },
            :uniqueness =>{:message => "亲，这个邮箱已经注册过了" },
            :format => { :with => /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.[a-z]+\Z/, :message => "您这是邮箱吗?" }
  validates :password, :presence => { :message => '亲，密码可不能为空' },
            :length => { :in => 6..32, :too_short => '不要这么短哦', :too_long  => '不要这么长哦'},
            :confirmation => {:message => '亲，要一样哦'}
  validates :phone_number, :presence => { :message => '电话一定要填的' }





  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
#定义用户头像的小图和中图最大宽高
  AVATAR_SW = 100
  AVATAR_SH = 100
  AVATAR_NW = 300
  AVATAR_NH = 300
  has_attached_file :avatar,
    :default_url => "/images/default_avatar.png", 
    :hash_secret => "efb40e6f2783c6d6641db8f1accdce15", 
    :styles => { :medium => "#{AVATAR_NW}x#{AVATAR_NH}>", :thumb => "#{AVATAR_SW}x#{AVATAR_SH}>" },
    :processors => [:jcropper],
    :dependent => :destroy
  validates_attachment :avatar,
    :content_type => { :content_type => /\Aimage\/.*\Z/ },
    :size => { :in => 0..4096.kilobytes }


#是否有要求的裁剪参数  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

#裁剪时获取图片原始尺寸
  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file avatar.path(style)
  end

#用户登录验证
  def self.authenticate(email, password)
    user = find_by_email(email)
    (user && user.password == password)? user : nil
  end

#是否管理员
  def admin?
    usertype==0
  end

end
