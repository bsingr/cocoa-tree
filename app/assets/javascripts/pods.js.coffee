# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  render_response = (response) ->
    console.log response
    pods = msgpack.decode(response)
    console.log pods
    html = JST['pods_tpl']
      pods: pods
    $('#list_placeholder').html(html)
    window.load_categories()
    $(".timeago").timeago()
  xhr = new XMLHttpRequest()
  xhr.open('GET', '/pods.mpac', true)
  xhr.responseType = 'arraybuffer'
  xhr.onload = (e) ->
    render_response(@.response)
  xhr.send()
    
$(document).ready(ready)
$(document).on('page:load', ready)
