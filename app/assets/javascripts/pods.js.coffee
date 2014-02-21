# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $.getJSON '/pods.json', (pods) ->
    template = doT.template($('#list_template').html())
    $('#list_placeholder').html(template({pods: pods}))
$(document).ready(ready)
$(document).on('page:load', ready)
