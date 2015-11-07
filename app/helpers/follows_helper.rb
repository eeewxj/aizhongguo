module FollowsHelper
  def can_follow_user(current_user_id, user_id)
    !!Follow.find_by_idol_id_and_follower_id(user_id, current_user_id).nil?
  end
end
