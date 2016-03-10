class UsersController < ApplicationController

before_action :validate_user_login, only: [:show, :edit, :update]
before_action :validate_admin_login, only: [:settype, :destroy]
before_action :validate_set_rights, only: [:show, :edit, :update]
  def index
    @users = User.where('user_type>?',User::TYPE_ADMIN)
    respond_to do |format|
      format.html # index.html.erb
      format.json #{ render json: @users }
    end
  end

  def check_available
    #binding.pry
    render json: {valid: User.check_email_available(params[:user][:email])}
  end

  def show
    #binding.pry
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json 
    end
  end


  def new
    @user = User.new
    respond_to do |format|
      format.html {render layout: "user"}
      format.json 
    end
  end


  def edit
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(create_user_params)
    #binding.pry
    if @user.save
      flash[:success] = 'User was successfully created.'
      reset_session
      session[:current_user_id]=@user.id
      respond_to do |format|
        format.html {
          if params[:user][:avatar].blank?
            redirect_to user_url(@user)
          else
            render :action => 'cropping'
          end
        }
        format.json {render '/user/index'}
      end
    else
      flash[:error] = 'Fail to create user!'
      @user = User.new
      respond_to do |format|
        format.html { render '/users/new'}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(update_user_params)
      flash[:notice] = 'User was successfully updated.'
      if (!@user.crop_x.blank? && !@user.crop_y.blank? && !@user.crop_w.blank? && !@user.crop_h.blank?)
        @user.avatar.reprocess!
      end
      respond_to do |format|
        format.html {
          if params[:user][:avatar].blank?
            redirect_to @user
          else
            render :action => 'cropping'
          end
        }
        format.json {render 'user/index'}
      end
    else
      render :action => "edit"
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def cropping
    respond_to do |format|
      format.html
    end
  end

  def settype
    @user = User.find(params[:id])
    if @user.update_attributes(:user_type => 3-@user.user_type)
      flash.now[:success] = 'user user_type set successfully!'
      if @user.user_type == User::VOLUNTEER
        @user.clean_management
        render :text => "<a href=\"/users/settype/#{@user.id}\" data-remote=\"true\" class = \"remote-settype-#{@user.id}\">志愿者，点击设为组长</a>"
      else
        render :text => "<a href=\"/users/settype/#{@user.id}\" data-remote=\"true\" class = \"remote-settype-#{@user.id}\">组长，点击设为志愿者</a>"
      end
    else  
      flash.now[:error] = 'fail to change user_type'
      render :text => "error_message_return:#{flash.now[:error]}"
    end
  end


  def manage
    @users = current_user.nursing_homes.map{ |n| n.projects.last.volunteers}.flatten
  end


  private
    def create_user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :phone_number, :user_type, :gender, :age, :self_description, :avatar, :address, 
        :work_unit, :avatar, :crop_x, :crop_y, :crop_w, :crop_h
      )
    end

    def update_user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :phone_number, :user_type, :gender, :age, :self_description, :avatar, :address, 
        :work_unit, :avatar, :crop_x, :crop_y, :crop_w, :crop_h
      )
    end

    def validate_set_rights
      unless (!current_user.nil? && (current_user.id.to_s==params[:id] || current_user.user_type<User.find(params[:id]).user_type))
          respond_to do |format|
            format.html do
              if request.xhr?
                flash.now[:error]="抱歉，您权限不够！"
                render :text => "error_message_return:#{flash.now[:error]}"
              else
                flash[:error]="抱歉，您权限不够！"
                redirect_back_or_default
              end
            end
           format.json {render :text => ({:error=>flash[:error]}).to_json}
         end
       end
    end

end
