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
