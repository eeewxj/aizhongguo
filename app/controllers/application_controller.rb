class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def redirect_back_or_default(default = root_path, options = {})
    redirect_to (request.referer.present? ? :back : default), options
  end

  def validate_user_login
    if current_user.nil?
      flash[:error]="抱歉，您尚未登录。"
      respond_to do |format|
        format.html {redirect_back_or_default}
        format.json {render :text => ({:error=>flash[:error]}).to_json}
      end
    end
  end

  def validate_admin_login
    unless !current_user.nil? && current_user.admin?
      respond_to do |format|
        format.html do
          if request.xhr?
            flash.now[:error]="抱歉，您不是管理员！"
            render :text => "error_message_return:#{flash.now[:error]}"
          else
            flash[:error]="抱歉，您不是管理员！"
            redirect_back_or_default
          end
        end
        format.json {render :text => ({:error=>flash[:error]}).to_json}
      end
    end
  end

  def validate_director_login
    unless !current_user.nil? && current_user.director?
      respond_to do |format|
        format.html do
          if request.xhr?
            flash.now[:error]="抱歉，您不是组长！"
            render :text => "error_message_return:#{flash.now[:error]}"
          else
            flash[:error]="抱歉，您不是组长！"
            redirect_back_or_default
          end
        end
        format.json {render :text => ({:error=>flash[:error]}).to_json}
      end
    end
  end

  def validate_volunteer_login
    unless !current_user.nil? && current_user.volunteer?
      respond_to do |format|
        format.html do
          if request.xhr?
            flash.now[:error]="抱歉，您不是普通志愿者！"
            render :text => "error_message_return:#{flash.now[:error]}"
          else
            flash[:error]="抱歉，您不是管理员！"
            redirect_back_or_default
          end
        end
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
