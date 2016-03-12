#//for bootstrapValidator
#//客户端表单验证
$(document).on "page:change", ->

  $.fn.bootstrapValidator.DEFAULT_OPTIONS = $.extend null, $.fn.bootstrapValidator.DEFAULT_OPTIONS,
    message: 'The field is not valid'
    feedbackIcons:
      valid: 'glyphicon glyphicon-ok'
      invalid: 'glyphicon glyphicon-remove'
      validating: 'glyphicon glyphicon-refresh'
#//用户登录页面
  $('#user_login').bootstrapValidator
    fields:
      'email':
        validators:
          notEmpty:
            message: '请输入邮箱帐号'
          emailAddress:
            message: '请填写格式正确的邮箱'
      'password':
        validators:
          notEmpty:
            message: '请填写密码'
          stringLength:
            min: 8
            max: 128
            message: '密码长度不对'
#//用户注册页面 TO DO 改为#new_user，修改内容
  $('#new_users').bootstrapValidator
    fields:
      'user[email]':
        validators:
          notEmpty:
            message: '请输入邮箱帐号'
          emailAddress:
            message: '请填写格式正确的邮箱'
          remote:
            message: '该邮箱已被注册！'
            url: '/users/check_available'
      'user[password]':
        validators:
          notEmpty:
            message: '请填写密码'
          stringLength:
            min: 8
            max: 128
            message: '密码长度需大于8位'
      'user[password_confirmation]':
        validators:
          notEmpty:
            message: '请再次输入以确认密码'
          identical:
            field: 'user[password]'
            message: '两次输入的密码不一致，请重新输入'
#//      'user[name]':
        validators:
          notEmpty:
            message: '请务必填写您的姓名'
#//      'user[phone_number]':
        validators:
          notEmpty:
            message: '请填写手机或电话号码'
          regexp:
            regexp: /^[+,\d][\s,\d,-]{9,20}$/
            message: '请正确输入手机或电话号码！'
#//      'user[birthday]':
        validators:
          notEmpty:
            message: '请选择您的出生年份'
#//      'user[avatar]':
        validators:
          file: 
            extension: 'jpg,jpeg,png,bmp,gif,tif,tiff'
            type: 'image/jpeg,image/png,image/tiff,image/gif,image/x-ms-bmp'
            maxSize: 2048 * 1024
            message: '上传图片格式须为jpg、jpeg、png、tiff、gif、bmp之一，且文件小于2MB'






