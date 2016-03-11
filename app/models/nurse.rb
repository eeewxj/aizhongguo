class Nurse < ActiveRecord::Base
  belongs_to :nursing_home
  has_many :nursings, dependent: :destroy
  has_many :residents, through: :nursings

#计算年龄，周岁
  def age
    age = Time.now.year - birthday.year
    (Time.now.month > birthday.month or (Time.now.month == birthday.month and Time.now.day >= birthday.day))? age : (age-1)
  end

end
