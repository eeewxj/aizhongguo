class Management < ActiveRecord::Base
  belongs_to :user
  belongs_to :director, class_name: "User", foreign_key: "user_id"
  belongs_to :nursing_home
end
