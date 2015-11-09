class UsersController < ApplicationController

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json #{ render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json 
    end
  end


  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
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
    #binding.pry
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
        format.json {render '/user/index'}
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

  private
    def create_user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :phone_number, :user_type, :gender, :age, :self_description, :avatar, :address, 
        :work_unit, :crop_x, :crop_y, :crop_w, :crop_h
      )
    end

    def update_user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :name, :phone_number, :user_type, :gender, :age, :self_description, :avatar, :address, 
        :work_unit, :crop_x, :crop_y, :crop_w, :crop_h
      )
    end
end
