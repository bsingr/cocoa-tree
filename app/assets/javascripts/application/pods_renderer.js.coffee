#= require jquery.timeago.js
class @PodsRenderer
  renderPods: (pods) ->
    html = JST['templates/pods']
      pods: pods
    $('#main-view').append(html)
    $(".timeago").timeago()
