module ApplicationHelper


  def link_to_current(name, options = {}, html_options = {}, &block)
      link_to(name, options, html_options.merge((current_page?(options))? {:id => 'current'}:{}), &block)
  end

  def current_user
    session[:current_user_id] && User.find_by_id(session[:current_user_id])
  end


  def get_all_nursing_homes_as_options
    @nursing_homes=NursingHome.all
    options=''
    @nursing_homes.each do |nursing_home| 
      options=options + "<option value=#{nursing_home.id}>#{nursing_home.name}</option>"
    end
    options.html_safe
  end


  def get_all_directors_as_options
    @directors=User.where("user_type = ?", 1)
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

end
