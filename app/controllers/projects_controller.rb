class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :direction,:notice]
  before_action :validate_director_login, only: [:new]
  before_action :validate_set_rights, only: [:edit, :create, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    if params[:nursing_home_id].nil?
      @draft_projects = Project.draft if !current_user.nil? && current_user.director?
      @published_projects = Project.published
      @upcoming_projects = current_user.upcoming_projects  unless current_user.nil?
      @ongoing_projects = current_user.ongoing_projects  unless current_user.nil?
      @unfinished_projects = current_user.unfinished_projects unless current_user.nil?
    else
      params[:offset] ||= 0
      params[:limit] ||= 1000
      @projects = NursingHome.find_by_id(params[:nursing_home_id]).projects.order("id desc").offset(params[:offset]).limit(params[:count])
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  # 代码存在bug，有待修复 TO DO
  def update 
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def direction
  end

  def notice
  end

  def manage
    @projects = Project.unfinished.where(:nursing_home_id => current_user.nursing_homes)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :nursing_home_id, :description, :start_at, :end_at, :staff_number, :contact_id, pickup_sites_attributes: [:id, :name, :project_id, :liaison, :phone_number, :meeting_time, :_destroy])
    end

    def validate_set_rights
      unless (!current_user.nil? && ((current_user.director? && !current_user.nursing_homes.empty? && current_user.nursing_homes.map(&:id).include?(@project.nil?? params[:project][:nursing_home_id].to_i : @project.nursing_home_id) ) || current_user.admin?))
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
