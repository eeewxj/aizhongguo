class ResidentsController < ApplicationController
  before_action :set_resident, only: [:show, :edit, :update, :destroy]
  before_action :validate_user_login
  before_action :validate_director_login, only: [:new]
  before_action :validate_set_rights, only: [:create, :destroy]
  # GET /residents
  # GET /residents.json
  def index
    if params[:room_id].nil?
      @residents = Resident.all
    else
      params[:offset] ||= 0
      params[:limit] ||= 1000
      if params[:nursing_home_id].nil?
        @residents = Room.find_by_id(params[:room_id]).residents.order("id desc").offset(params[:offset]).limit(params[:count])
      else
        @residents = NursingHome.find_by_id(params[:nursing_home_id]).rooms.find_by_id(params[:room_id]).residents.order("id desc").offset(params[:offset]).limit(params[:count])
      end
    end
  end

  # GET /residents/1
  # GET /residents/1.json
  def show
  end

  # GET /residents/new
  def new
    @resident = Resident.new
  end

  # GET /residents/1/edit
  def edit
  end

  # POST /residents
  # POST /residents.json
  def create
    @resident = Resident.new(resident_params)

    respond_to do |format|
      if @resident.save
        format.html { redirect_to @resident, notice: 'Resident was successfully created.' }
        format.json { render :show, status: :created, location: @resident }
      else
        format.html { render :new }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /residents/1
  # PATCH/PUT /residents/1.json
  def update
    respond_to do |format|
      if @resident.update(resident_params)
        format.html { redirect_to @resident, notice: 'Resident was successfully updated.' }
        format.json { render :show, status: :ok, location: @resident }
      else
        format.html { render :edit }
        format.json { render json: @resident.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /residents/1
  # DELETE /residents/1.json
  def destroy
    @resident.destroy
    respond_to do |format|
      format.html { redirect_to residents_url, notice: 'Resident was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resident
      @resident = Resident.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resident_params
      params.require(:resident).permit(:name, :gender, :birthday, :condition, :phone_number, :contact, :contact_phone_number, :room_id)
    end

    def validate_set_rights
      unless (!current_user.nil? && ((current_user.director? && !current_user.nursing_home.nil? && current_user.nursing_home.id.to_s==(@resident.nil?? Room.find(params[:resident][:room_id]).nursing_home_id.to_s : @room.nursing_home_id.to_s)) || current_user.admin?))
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
