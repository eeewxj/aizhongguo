class NursingHomesController < ApplicationController
  before_action :set_nursing_home, only: [:show, :edit, :update, :destroy]
  before_action :validate_set_rights, only: [:edit, :update]
  before_action :validate_admin_login, only: [:new, :create, :destroy]
  # GET /nursing_homes
  # GET /nursing_homes.json
  def index
    @nursing_homes = NursingHome.all
  end

  # GET /nursing_homes/1
  # GET /nursing_homes/1.json
  def show
  end

  # GET /nursing_homes/new
  def new
    @nursing_home = NursingHome.new
  end

  # GET /nursing_homes/1/edit
  def edit
  end

  # POST /nursing_homes
  # POST /nursing_homes.json
  def create
    @nursing_home = NursingHome.new(nursing_home_params)

    respond_to do |format|
      if @nursing_home.save
        format.html { redirect_to @nursing_home, notice: 'Nursing home was successfully created.' }
        format.json { render :show, status: :created, location: @nursing_home }
      else
        format.html { render :new }
        format.json { render json: @nursing_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nursing_homes/1
  # PATCH/PUT /nursing_homes/1.json
  def update
    respond_to do |format|
      if @nursing_home.update(nursing_home_params)
        format.html { redirect_to @nursing_home, notice: 'Nursing home was successfully updated.' }
        format.json { render :show, status: :ok, location: @nursing_home }
      else
        format.html { render :edit }
        format.json { render json: @nursing_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nursing_homes/1
  # DELETE /nursing_homes/1.json
  def destroy
    @nursing_home.destroy
    respond_to do |format|
      format.html { redirect_to nursing_homes_url, notice: 'Nursing home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nursing_home
      @nursing_home = NursingHome.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nursing_home_params
      params.require(:nursing_home).permit(:name, :address, :contact, :phone_number, :description, :website)
    end

    def validate_set_rights
      unless (!current_user.nil? && ((current_user.director? && !current_user.nursing_homes.nil? && current_user.nursing_homes.map(&:id).include?(params[:id].to_i)) || current_user.admin?))
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
