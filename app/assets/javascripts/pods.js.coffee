# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class @PodsProgressBar
  update: (chunk_id) ->
    progress = (chunk_id / (gon.pods_index.length - 1)) * 100
    $('.progress-bar').css('width', progress + '%')
  start: ->
    $('.progress-container').hide().html($('.progress-tpl').html()).slideDown(1000)
  finish: ->
    $('.progress').slideUp(1000)
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
    @progressBar = new PodsProgressBar()
    @fetcher = new PodsFetcher()
    @fetcher.delegate = @
  pods: []
  loadPods: ->
    @fetcher.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    @progressBar.update(chunk_id)
    @pods = @pods.concat(pods)
  didLoadAll: ->
    @progressBar.finish()
class @PodsRenderer
  renderPods: (pods) ->
    html = JST['templates/pods']
      pods: pods
    $('#list_placeholder').html(html)
    window.load_categories()
    $(".timeago").timeago()
class @PodsNavigator
  index: 0
  max_size: 50
  constructor: (podsController) ->
    @podsController = podsController
    @render()
  render: ->
    controller = @
    html = JST['templates/pods_navigator'](@)
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
    renderer = new PodsRenderer
    renderer.renderPods(pods)
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
  podsController.loadPods()
  $("a[href='#!/reload").click ->
    podsController.loadPods()
  window.podsNavigator = new PodsNavigator(podsController)
$(document).ready(ready)
$(document).on('page:load', ready)
