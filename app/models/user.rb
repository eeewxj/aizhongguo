class User < ActiveRecord::Base
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :commit
#定义用户头像的小图和中图最大宽高
  AVATAR_SW = 55
  AVATAR_SH = 55
  AVATAR_NW = 300
  AVATAR_NH = 300
  has_attached_file :avatar,
    :default_url => "/images/:style/missing.png", 
    :hash_secret => "efb40e6f2783c6d6641db8f1accdce15", 
    :styles => { :medium => "#{AVATAR_NW}x#{AVATAR_NH}>", :thumb => "#{AVATAR_SW}x#{AVATAR_SH}>" },
    :processors => [:jcropper],
    :dependent => :destroy
  validates_presence_of :avatar
  validates_attachment :avatar,
    :content_type => { :content_type => /\Aimage\/.*\Z/ },
    :size => { :in => 0..2048.kilobytes }


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
