class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def validate_user_login
    if current_user.nil?
      flash[:error]="抱歉，您尚未登录。"
      respond_to do |format|
        format.html {redirect_to :back}
        format.json {render :text => ({:error=>flash[:error]}).to_json}
      end
    end
  end

  def validate_admin_login
    validate_user_login
    unless current_user.admin?
      flash.now[:error]="抱歉，您不是管理员！"
      respond_to do |format|
        format.html {render :text => "error_message_return:#{flash.now[:error]}"}
        format.json {render :text => ({:error=>flash[:error]}).to_json}
      end
    end
  end

  def validate_director_login
    validate_user_login
    unless current_user.director?
      flash.now[:error]="抱歉，您不是组长！"
      respond_to do |format|
        format.html {render :text => "error_message_return:#{flash.now[:error]}"}
        format.json {render :text => ({:error=>flash[:error]}).to_json}
      end
    end
  end

  def validate_volunteer_login
    unless current_user.volunteer?
      flash.now[:error]="抱歉，您不是普通志愿者！"
      respond_to do |format|
        format.html {render :text => "error_message_return:#{flash.now[:error]}"}
        format.json {render :text => ({:error=>flash[:error]}).to_json}
      end
    end
  end
  
  private
 
  # Finds the User with the ID stored in the session with the key
  # :current_user_id This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  # logging out removes it.
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by_id(session[:current_user_id])
  end
end
