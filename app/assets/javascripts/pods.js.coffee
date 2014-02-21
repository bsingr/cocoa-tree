# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  render_response = (response) ->
    pods = msgpack.decode(response)
    html = JST['pods_tpl']
      pods: pods
    $('#list_placeholder').append(html)
    window.load_categories()
    $(".timeago").timeago()
  request_pods = (chunk_id) ->
    xhr = new XMLHttpRequest()
    xhr.open('GET', '/pods/'+chunk_id+'.mpac', true)
    xhr.responseType = 'arraybuffer'
    xhr.onload = (e) ->
      render_response(@.response)
    xhr.send()
  for chunk in gon.pods_index
    request_pods(chunk[0])

$(document).ready(ready)
$(document).on('page:load', ready)
