#所有的常量定义在此文件中，如某个字段值对应的文字含义等
#调用示例如下：
# Constants::GENDER.key(value)来获取对应的文字
# Constants::GENDER[key]来获取文字对应的字段值
module Constants

  GENDER = {"男" => false, "女" => true}
  GENDERPRON = {"他" => false, "她" => true}
  EDUCATION = { "不识字" => 0, "小学" => 1, "初高中" => 2, "大学" => 3, "硕士/博士" => 4}
  NURSINGTYPE = { "不能自理" => 0, "半自理" => 1, "完全自理" => 2}
  MAX_NUMBER_OF_LIST_LINE = 12
#定义用户类型
  TYPE_ADMIN = 0 #超级管理员
  TYPE_DIRECTOR = 1 #组长，管理单个养老院
  TYPE_VOLUNTEER = 2 #志愿者，权限最低
#定义用户头像的小图和中图最大宽高
  AVATAR_SW = 100
  AVATAR_SH = 100
  AVATAR_NW = 300
  AVATAR_NH = 300

end
