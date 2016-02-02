#encoding: utf-8
class UserController < ApplicationController
  before_filter :validate_user_login, :only=>[:logout]


  def index
    @user = current_user
    if @user.nil?
      respond_to do |format|
        format.html #{render "index.html.erb" }
        format.json #{ render json: @users }
      end
    else
    #用户已经登录的情况下跳转到活动中心
      redirect_to projects_path
    end
  end

  def login
    @user = User.authenticate(params[:email], params[:password])
    unless @user.nil?
      reset_session
      session[:current_user_id]=@user.id
      flash[:success] = "登录成功"
      respond_to do |format|
        format.html {redirect_back_or_default}
        format.json {render 'user/index'}
      end
    else
      flash[:error] = "您的用户名或密码错误！"
      respond_to do |format|
        format.html {render :text => flash[:error]}
        format.json {render :text => ({:error=>flash[:error]}).to_json}
      end      
    end
  end

  def logout
    session[:current_user_id] = nil
    flash[:success] = "退出登录成功"
    respond_to do |format|
      format.html {redirect_to root_path }
      format.json {render :text => ({:success=>flash[:success]}).to_json}
    end
  end
end
