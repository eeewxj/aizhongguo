jQuery ->
#格式化button
  $('.button').button();
#延时动作
#淡出
  $(->setTimeout(->
    $("div[class^='message_of_']").fadeOut(1200)
  ,2000))
#flash提示在淡出后删除
  $(->setTimeout(->
    $("div[class^='message_of_']").remove()
  ,3200))
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
#ajax返回结果替代原来的块
  $("a.remote,form[data-remote='true']").on('ajax:complete', (status,xhr)->  
    if xhr.responseText.match("error_message_return:") == null
      $(this).replaceWith(xhr.responseText)
    else
      alert((xhr.responseText).substr(21)))
#ajax返回结果替代原来的块及其父块
  $("a.remote_all").on('ajax:complete', (status,xhr)->  
    if xhr.responseText.match("error_message_return:") == null
      $(this).parent().replaceWith(xhr.responseText)
    else
      alert(xhr.responseText).substr(21))




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









