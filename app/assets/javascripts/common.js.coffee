$(document).on "page:change", ->
#格式化button
  $('.button').button();
#延时动作
#flash淡出
  $(->setTimeout(->
    $("div[class^='message_of_']").fadeOut(1200)
  ,2500))
#flash提示在淡出后删除
  $(->setTimeout(->
    $("div[class^='message_of_']").remove()
  ,3700))
#滑入
  $(->setTimeout(->
    $("div.ui-state-error").slideUp(1000)
  , 2000))

#点击动作
#淡出
  $("div[class^='message_of_']").on("click",->
    $(this).fadeOut(1200))

#为删除动作添加确认
  $("a.delete").click(-> return confirm('确认删除？'))

##全局ajax返回结果处理
  $(document).ajaxComplete((event,xhr,settings)->
#替代原来的块或父块
    arr = settings.url.split('/')
    if xhr.responseText.match("error_message_return:") == null
      if arr[arr.length-1].indexOf('?') != -1
        arr[arr.length-1] = arr[arr.length-1].substring(0,arr[arr.length-1].indexOf('?'))
      $("a.remote-"+arr[arr.length-2]+"-"+arr[arr.length-1]+",form[data-remote='true']").replaceWith(xhr.responseText)
      $("a.remote_all-"+arr[arr.length-2]).parent().replaceWith(xhr.responseText)
    else
      alert((xhr.responseText).substr(21)))


#自动填写表单
  if ($.cookie("rmbUser") == "true") 
    $("#rmbUser").attr("checked", true)
    $("#name").val($.cookie("name"))
    $("#password").val($.cookie("password"))  
#绑定保存用户信息函数
  $("form").submit(-> 
    if ($("#rmbUser").attr("checked") == "checked")
      name = $("#name").val()
      password = $("#password").val()
      $.cookie("rmbUser", "true", { expires: 7 })  
      $.cookie("name", name, { expires: 7 }) 
      $.cookie("password", password, { expires: 7 })
    else 
      $.cookie("rmbUser", "false", { expires: -1 })
      $.cookie("name", '', { expires: -1 })
      $.cookie("password", '', { expires: -1 }))

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

#对于可能的多个嵌套子表单，完成一个后添加空白表单
  $(document).on("change","div.field.multiupload",->
    if !$(this).next().hasClass("multiupload")
      next = $(this).html()
      next = next.replace(/_(\d+)_/g, '_'+(Number(next.match(/_(\d+)_/)[1])+1)+'_')
      if Number(next.match(/_(\d+)_/)[1])==1
        next = next+"<span class=\"glyphicon glyphicon-remove-circle\"></span>"
      $(this).after("<div class='field multiupload'>"+next+"</div>")
  )


#点击展开及收起
  $(".toggle_btn").click(->
    $(this).children(".glyphicon").toggleClass("glyphicon-backward")
    $(this).children(".glyphicon").toggleClass("glyphicon-forward")
    $(this).parent().next(".text").animate({height: 'toggle', opacity: 'toggle'}, "fast")
  )
#点击删除按钮删除父级div
  $(document).on("click", "span.glyphicon.glyphicon-remove-circle", ->
    $(this).parent().remove()
  )



  return







