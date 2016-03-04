require 'open-uri'
module ApplicationHelper

  User::ADMIN = 0
  User::DIRECTOR = 1
  User::VOLUNTEER = 2
  def link_to_current(name, options = {}, html_options = {}, &block)
      link_to(name, options, html_options.merge((current_page?(options))? {id: 'current'}:{}), &block)
  end

  def current_user
    session[:current_user_id] && User.find_by_id(session[:current_user_id])
  end


  def get_all_applicants_as_options(project)
    options=''
    project.applicants.each do |applicant|
      options=options + "<option value=#{applicant.id}>#{applicant.name}</option>"
    end
    options.html_safe
  end

  def get_all_nursing_homes_as_options
    @nursing_homes=NursingHome.all
    options=''
    @nursing_homes.each do |nursing_home| 
      options=options + "<option value=#{nursing_home.id}>#{nursing_home.name}</option>"
    end
    options.html_safe
  end


  def get_all_directors_as_options(nursing_home = nil)
    if nursing_home.nil?
      @directors=User.where("user_type = ?", User::DIRECTOR)
    else
      @directors = User.where(user_type: User::DIRECTOR).joins(:managements).where(managements: { nursing_home_id: nursing_home.id })
    end
    options=''
    @directors.each do |director| 
      options=options + "<option value=#{director.id}>#{director.name}</option>"
    end
    options.html_safe
  end

  def get_all_projects_as_options
    @projects=Project.all #model中添加“可申请的活动”方法
    options=''
    @projects.each do |project| 
      options=options + "<option value=#{project.id}>#{project.name}</option>"
    end
    options.html_safe
  end

  def get_all_pickup_sites_as_options(project)
    @pickup_sites = project.pickup_sites
    options=''
    @pickup_sites.each do |pickup_site|
      options=options + "<option value=#{pickup_site.id}>#{pickup_site.name}</option>"
    end
    options.html_safe
  end

  def get_all_zones_as_options(nursing_home)
    @zones=nursing_home.zones
    options=''
    @zones.each do |zone| 
      options=options + "<option value=#{zone.id}>#{zone.name}</option>"
    end
    options.html_safe
  end

  def get_all_residents_as_options(nursing_home)
    @residents=nursing_home.residents
    options=''
    @residents.each do |resident| 
      options=options + "<option value=#{resident.id}>#{resident.name}</option>"
    end
    options.html_safe
  end

  def get_all_rooms_as_options(director)
    @rooms=director.nursing_home.rooms
    options=''
    @rooms.each do |room| 
      options=options + "<option value=#{room.id}>#{room.room_number}</option>"
    end
    options.html_safe
  end

  def get_genders_as_options
    "<option value=false>男</option><option value=true>女</option>".html_safe
  end

  def get_gender(gender)
    case gender
      when false
        return "男"
      else
        return "女"
    end
  end

end
