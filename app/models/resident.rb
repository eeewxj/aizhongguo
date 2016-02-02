class Resident < ActiveRecord::Base
  belongs_to :room
  belongs_to :zone
  has_many :records

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
