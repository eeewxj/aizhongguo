class Application < ActiveRecord::Base
  belongs_to :user
  belongs_to :volunteer, class_name: "User", foreign_key: "user_id"
  belongs_to :project
end

