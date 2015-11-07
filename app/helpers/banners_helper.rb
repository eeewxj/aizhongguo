module BannersHelper
  def can_like_banner(current_user_id, banner_id)
    !!BannerLike.find_by_banner_id_and_user_id(banner_id, current_user_id).nil?
  end

  def can_subscribe_banner(current_user_id, banner_id)
    !(Banner.find_by_id(banner_id).schools & User.find_by_id(current_user_id).schools).blank?
  end

  def have_subscribed_banner(current_user_id, banner_id)
    User.find_by_id(current_user_id).banners.include?(Banner.find_by_id(banner_id))
  end

end
