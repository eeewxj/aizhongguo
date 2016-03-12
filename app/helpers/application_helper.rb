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


##以下get_all_*类方法都可以替换为 get_attrs_as_options
  def get_all_applicants_as_options(project)
    options=''
    project.applicants.each do |applicant|
      options=options + "<option value=#{applicant.id}>#{applicant.name}</option>"
    end
    options.html_safe
  end

  def get_all_nursing_homes_as_options
    @nursing_homes=current_user.nursing_homes
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


#该方法不安全，需要注意，arr 是对象数组，attr_name是要调用的对象方法，
#输出结果将数组中所有对象的对应方法返回结果组成选单选项
#应该改成输出二维数组或者hash格式，不需要直接生成字符串
#如：
#arr.map{|a| [a.send(attr_name), a.id]}

  def get_attrs_as_options(arr, attr_name)
    options = ''
    arr.each do |a|
      options = options + "<option value=#{a.id}>#{a.send(attr_name)}</option>"
    end
    options.html_safe
  end


end
