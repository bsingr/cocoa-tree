# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class PodsFetcher
  delegate: null
  requests: []
  cancel: ->
    for request in @requests
      request.abort()
    @requests = []
  loadPods: ->
    @cancel()
    for chunk in gon.pods_index
      @loadPodsChunk(chunk[0])
  loadPodsChunk: (chunk_id) ->
    controller = @
    xhr = new XMLHttpRequest()
    xhr.open('GET', '/pods/'+chunk_id+'.mpac', true)
    xhr.responseType = 'arraybuffer'
    xhr.onload = (e) ->
      pods = msgpack.decode(@response)
      controller.podsChunkDidLoad(chunk_id, pods)
    xhr.send()
    @requests.push(xhr)
  podsChunkDidLoad: (chunk_id, pods) ->
    if @delegate
      if @delegate.didLoad
        @delegate.didLoad(chunk_id, pods)
      if @delegate.didLoadAll
        if (gon.pods_index[gon.pods_index.length - 1][0] == chunk_id)
          @delegate.didLoadAll()
class @PodsController
  constructor: ->
    @fetcher = new PodsFetcher()
    @fetcher.delegate = @
  pods: []
  loadPods: ->
    @fetcher.loadPods()
  didLoad: (chunk_id, pods) ->
    progress = (chunk_id / (gon.pods_index.length - 1)) * 100
    $('.progress-bar').css('width', progress + '%')
    @pods = @pods.concat(pods)
  didLoadAll: ->
    $('.progress').slideUp(1000)
    @renderPods(@pods)
  renderPods: (pods) ->
    html = JST['pods_tpl']
      pods: pods
    $('#list_placeholder').append(html)
    window.load_categories()
    $(".timeago").timeago()

ready = ->
  (new PodsController).loadPods()
$(document).ready(ready)
$(document).on('page:load', ready)
