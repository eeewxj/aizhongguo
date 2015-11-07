jQuery ->
#图片裁剪测试
  showCoords = (c) ->
    $('#x1').val(c.x)
    $('#y1').val(c.y)
    $('#x2').val(c.x2)
    $('#y2').val(c.y2)
    $('#w').val(c.w)
    $('#h').val(c.h)
    return
  clearCoords = ->
    $('#coords input').val('')
    return

  $('#target_base').Jcrop()
  $('#jcrop_target').Jcrop({
    onChange:   showCoords
    onSelect:   showCoords
    onRelease:  clearCoords
  })
#上传图片后添加上传框
  $("div.field.multiupload").on("change",->
    if !$(this).next().hasClass("multiupload")
      next = $(this).html()
      next = next.replace(/(\d+)/g, (Number(next.match(/\d+/))+1))
      $(this).after("<div class='field multiupload'>"+next+"</div>")
  )

#更改注册表单
  form_switch = -> 
    if ($("select#user_usertype").val() == '1') 
      $("div.personal").hide()
      $("div.personal").find(".field_with_errors").removeClass("field_with_errors")      
      $("div.groupal").show()
    else
      $("div.personal").show()
      $("div.groupal").hide() 
      $("div.groupal").find(".field_with_errors").removeClass("field_with_errors")  
  form_switch()
  $("select#user_usertype").on("change", form_switch )
#填写正确提交之前删除不必要参数，以便以后改成嵌套表单
  $("form#user_new").submit( (e)->
    if ($(".field_with_errors").size() == 0 )
      if ($("select#user_usertype").val() == '1')
        $("div.personal").remove()
      else
        $("div.groupal").remove()     
  )

#MD5加密
  $("input[type='password']").parentsUntil("form").parent().submit(->
    if ($(this).find(".field_with_errors").size() == 0 )
      encrypted_password = hex_md5($(this).find("input[type='password']").attr("value"))
      $(this).find("input[type='password']").attr("value", encrypted_password)
  )




  return
