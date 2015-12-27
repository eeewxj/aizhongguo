class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action :validate_user_login, only: [:new, :create, :show]
  before_action :validate_set_rights, only: [:edit, :update, :destroy]
  # GET /records
  # GET /records.json
  def index
    @records = Record.all
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
    @record.user_id = current_user.id
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit( :resident_id, :project_id, :desc)
    end

    def validate_set_rights
      unless (!current_user.nil? && ((current_user.director? && !current_user.nursing_home.nil? && current_user.nursing_home.id==@record.project.nursing_home_id) || current_user.admin?))
          respond_to do |format|
            format.html do
              if request.xhr?
                flash.now[:error]="抱歉，您权限不够！"
                render :text => "error_message_return:#{flash.now[:error]}"
              else
                flash[:error]="抱歉，您权限不够！"
                #binding.pry
                redirect_back_or_default
              end
            end
           format.json {render :text => ({:error=>flash[:error]}).to_json}
         end
       end
    end
end
