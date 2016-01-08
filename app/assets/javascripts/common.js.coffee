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
#ajax返回结果替代原来的块或父块
  $(document).ajaxComplete((event,xhr,settings)->
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









