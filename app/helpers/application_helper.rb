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


  def get_all_directors_as_options(nursing_home = nil)
    if nursing_home.nil?
      @directors=User.where("user_type = ?", User::DIRECTOR)
    else
      @directors = nursing_home.directors
    end
    get_attrs_as_options(@directors, "name")
  end

#该方法不安全，需要注意。arr 是对象数组，attr_name是要调用的对象方法，输出二维数组
#该方法可以改用collection_select 替换，避免用send函数
  def get_attrs_as_options(arr, attr_name)
    arr.map{|a| [a.send(attr_name), a.id]}
  end

end
