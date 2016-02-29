class Resident < ActiveRecord::Base

#定义用户头像的小图和中图最大宽高
  AVATAR_SW = 100
  AVATAR_SH = 100
  AVATAR_NW = 300
  AVATAR_NH = 300
##可用参数##
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h


  belongs_to :room
  belongs_to :zone
  has_many :records
  has_many :nursings
  has_many :nurses, through: :nursings


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




  def show_gender
    Constants::GENDER.key(gender)
  end

  def show_education
    Constants::EDUCATION.key(education) || ''
  end

  def show_nursing_type
    Constants::NURSINGTYPE.key(nursing_type) || ''
  end

#计算年龄，周岁
  def age
    age = Time.now.year - birthday.year
    (Time.now.month > birthday.month or (Time.now.month == birthday.month and Time.now.day >= birthday.day))? age : (age-1)
  end

  def zone
    Resident.find(id).room.zone
  end

  def nursing_home
    Resident.find(id).room.zone.nursing_home
  end

end
