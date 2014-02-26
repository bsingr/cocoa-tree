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
    $('.progress-container').html($('.progress-tpl').html())
  didLoad: (chunk_id, pods) ->
    progress = (chunk_id / (gon.pods_index.length - 1)) * 100
    $('.progress-bar').css('width', progress + '%')
    @pods = @pods.concat(pods)
  didLoadAll: ->
    $('.progress').slideUp(1000)
  renderPods: (pods) ->
    html = JST['pods_tpl']
      pods: pods
    $('#list_placeholder').html(html)
    window.load_categories()
    $(".timeago").timeago()
class @PodsNavigator
  index: 0
  max_size: 2
  constructor: (podsController) ->
    @podsController = podsController
    @render()
  render: ->
    controller = @
    html = JST['pods_navigator_tpl'](@)
    $('#list_navigator').html(html)
    $('#list_navigator a').click ->
      href = $(@).attr('href')
      command = href.replace('#!/pods/', '')
      if command == 'next'
        controller.next()
      else
        controller.prev()
  has_next: ->
    (@index + 1) < gon.pods_count
  has_prev: ->
    @index > 0
  renderPods: ->
    pods = @podsController.pods[@index..(@index+@max_size-1)]
    @podsController.renderPods(pods)
  next: ->
    @index += @max_size
    @renderPods()
    @render()
  prev: ->
    @index -= @max_size
    @renderPods()
    @render()
ready = ->
  podsController = new PodsController
  $("a[href='#!/reload").click ->
    podsController.loadPods()
  window.podsNavigator = new PodsNavigator(podsController)
$(document).ready(ready)
$(document).on('page:load', ready)
