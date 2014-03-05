class @PodsProgressBar
  update: (factor) ->
    progress = factor * 100
    $('.progress-bar').css('width', progress + '%')
  start: ->
    $('.progress-container').hide().html($('.progress-tpl').html()).slideDown(1000)
  finish: ->
    $('.progress').slideUp(1000)
