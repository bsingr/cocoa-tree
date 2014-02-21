# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $.getJSON '/pods.json', (pods) ->
    html = JST['pods_tpl']
      pods: pods
    $('#list_placeholder').html(html)
    window.load_categories()
    $(".timeago").timeago()
$(document).ready(ready)
$(document).on('page:load', ready)
