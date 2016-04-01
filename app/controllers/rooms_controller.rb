class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :validate_user_login
  before_action :validate_set_rights, only: [:create, :destroy, :edit]
  # GET /rooms
  # GET /rooms.json
  def index
    if params[:nursing_home_id].nil?
      @rooms = Room.all
    else
      params[:offset] ||= 0
      params[:limit] ||= 1000
      @rooms = NursingHome.find_by_id(params[:nursing_home_id]).rooms.order("id desc").offset(params[:offset]).limit(params[:count])
    end
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
    if current_user.director?
      @nursing_homes = current_user.nursing_homes
    else
      if current_user.admin?
        @nursing_homes = NursingHome.all
      end
    end
  end

  # GET /rooms/1/edit
  def edit
    @nursing_home = @room.zone.nursing_home
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:room_number, :description, :zone_id)
    end

    def validate_set_rights
      unless (!current_user.nil? && ((current_user.director? && !current_user.nursing_homes.empty? && current_user.nursing_homes.map(&:id).include?(@room.nil?? Zone.find_by_id(params[:room][:zone_id]).nursing_home_id : @room.zone.nursing_home_id )) || current_user.admin?))
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
