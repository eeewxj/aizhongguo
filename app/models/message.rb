class Message < ActiveRecord::Base
#message的status为二进制3位如000，第一位表示发信人已经是否删除此消息
#第二位表示收件人是否已经删除此消息，第三位表示收件人是否已经阅读此消息
#一条消息初建的时候为000或者100，即0或4，系统消息会默认被系统删除
#最后到达110或者111，一旦消息进入11*,即删除消息

  def update_status(current_user_id)
    if current_user_id==user_id
      write_attribute(:status, status+1-status[0])
      save
    end
  end
end
