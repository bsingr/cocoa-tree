# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @PodsController
  loadPods: ->
    for chunk in gon.pods_index
      @.loadPodsChunk(chunk[0])
  loadPodsChunk: (chunk_id) ->
    controller = @
    xhr = new XMLHttpRequest()
    xhr.open('GET', '/pods/'+chunk_id+'.mpac', true)
    xhr.responseType = 'arraybuffer'
    xhr.onload = (e) ->
      controller.renderPodsChunk(@.response, chunk_id)
    xhr.send()
  renderPodsChunk: (response, chunk_id) ->
    pods = msgpack.decode(response)
    html = JST['pods_tpl']
      pods: pods
    $('#list_placeholder').append(html)
    progress = (chunk_id / (gon.pods_index.length - 1)) * 100
    $('.progress-bar').css('width', progress + '%')
    if (gon.pods_index[gon.pods_index.length - 1][0] == chunk_id)
      $('.progress').slideUp(1000)
      window.load_categories()
      $(".timeago").timeago()

ready = ->
  (new PodsController).loadPods()
$(document).ready(ready)
$(document).on('page:load', ready)
