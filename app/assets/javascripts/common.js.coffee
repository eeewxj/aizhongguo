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
#替代原来的块或父块***多个相同form的处理 TO DO
    arr = settings.url.split('/')
    if xhr.responseText.match("error_message_return:") == null
      if arr[arr.length-1].indexOf('?') != -1
        arr[arr.length-1] = arr[arr.length-1].substring(0,arr[arr.length-1].indexOf('?'))
      $("a.remote-"+arr[arr.length-2]+"-"+arr[arr.length-1]).replaceWith(xhr.responseText)
      $("a.remote_all-"+arr[arr.length-2]).parent().replaceWith(xhr.responseText)
      $("form[data-remote='true']").replaceWith(xhr.responseText)
      #下面if语句专门用来处理为志愿者分配区域的ajax返回结果
      if xhr.responseText.indexOf("assignment_user_id") != -1
        re = new RegExp(/name="assignment\[user_id\]" type="number" value="(\d+)"/)
        alpha = xhr.responseText.match(re)
        $("input[value='"+alpha[1]+"'][name='assignment[user_id]']").parent().parent().replaceWith(xhr.responseText)
      #下面if语句专门用来处理为老人分配护工的ajax返回结果
      if xhr.responseText.indexOf("nursing_resident_id") != -1
        re = new RegExp(/name="nursing\[resident_id\]" type="number" value="(\d+)"/)
        alpha = xhr.responseText.match(re)
        $("input[value='"+alpha[1]+"'][name='nursing[resident_id]']").parent().parent().replaceWith(xhr.responseText)

    else
      alert((xhr.responseText).substr(21)))


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
      next = next.replace(/\[(\d+)\]/g, '['+(Number(next.match(/\[(\d+)\]/)[1])+1)+']')
        
      $(this).after("<div class='field multiupload col-xs-12 input-group form-group'>"+next+"</div>")
  )


#点击展开及收起
  $(".toggle_btn").click(->
    $(this).children(".glyphicon").toggleClass("glyphicon-backward")
    $(this).children(".glyphicon").toggleClass("glyphicon-forward")
    $(this).parent().next(".text").animate({height: 'toggle', opacity: 'toggle'}, 500)
  )

#点击全部展示及部分展示
  $(".extend_btn").click(->
    $(this).children(".glyphicon").toggleClass("glyphicon-backward")
    $(this).children(".glyphicon").toggleClass("glyphicon-forward")
    $(this).parent().find(".simplified").animate({height: 'toggle', opacity: 'toggle'}, 500)
    $(this).parent().find(".extended").animate({height: 'toggle', opacity: 'toggle'}, 500)
  )

#点击删除按钮删除父级div
  $(document).on("click", "span.glyphicon.glyphicon-remove-circle", ->
    $(this).parent().remove()
  )

#卡片颜色切换
  color_list = ["#D2F1E3", "#F8D4DC", "#F1EEB2", "#fff"]
  $(".switch").each (index)->
    color = color_list[index%color_list.length]
    $(this).find("td:nth-child(1)").css('background-color', color)

  return







