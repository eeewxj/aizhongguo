$(document).on "page:change", ->

  $.fn.bootstrapValidator.DEFAULT_OPTIONS = $.extend null, $.fn.bootstrapValidator.DEFAULT_OPTIONS,
    message: 'The field is not valid'
    feedbackIcons:
      valid: 'glyphicon glyphicon-ok'
      invalid: 'glyphicon glyphicon-remove'
      validating: 'glyphicon glyphicon-refresh'

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
            message: '长度不对'




  $('#new_user').bootstrapValidator
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


  $('#sign_up form#new_user').bootstrapValidator
    fields:
      'user[email]':
        validators:
          remote:
            message: '该邮箱已被注册！'
            url: 'users/check_available'
      'user[password]':
        validators:
          stringLength:
            min: 8
            max: 128
          identical:
            field: 'user[password_confirmation]'
            message: '两次输入的密码不一致，请重新输入'
      'user[password_confirmation]':
        validators:
          notEmpty:
            message: '请再次输入以确认密码'
          identical:
            field: 'user[password]'
            message: '两次输入的密码不一致，请重新输入'

  $("form#new_job,form[id^='edit_job_']").bootstrapValidator
    fields:
      'job[salary_high]':
        validators:
          integer:
            message: ''
          notEmpty:
            message: '请填写最高月薪'
          lessThan:
            value: '1000'
            message: '您填写的月薪太高了！'
          greaterThan:
            inclusive: true
            value: 'job[salary_low]'
            message: '不能低于最低月薪'

  $("form[id^='edit_graduate_']").bootstrapValidator
    fields:
      'graduate[phone]':
        validators:
          notEmpty:
            message: '请填写电话号码'
          regexp:
            regexp: /^[+,\d][\s,\d,-]{9,20}$/
            message: '请正确输入电话号码！'


  $("form[id^='edit_company_']").bootstrapValidator
    fields:
      'company[avatar]':
        validators:
          notEmpty:
            message: '请上传公司logo'
          file: 
            extension: 'jpg,jpeg,png,bmp,gif,tif,tiff'
            type: 'image/jpeg,image/png,image/tiff,image/gif,image/x-ms-bmp'
            maxSize: 2048 * 2048
            message: '上传图片格式须为jpg、jpeg、png、tiff、bmp之一，且小于2048x2048'




