loadIndex = (callback) ->
  xhr = new XMLHttpRequest()
  xhr.open('GET', '/pods.mpac', true)
  xhr.responseType = 'arraybuffer'
  xhr.onload = (e) ->
    index = msgpack.decode(@response)
    callback(index)
  xhr.send()

boot = (index) ->
  podsLoader = new PodsLoader(index)
  podsController = new PodsController(podsLoader)
  podsController.loadPods()
  window.podsController = podsController
  window.podsFilterRenderer = new PodsFilterRenderer(podsController)
  window.podsNavigation = new PodsNavigation(podsController)
  new AppRouter()
  Backbone.history.start()
ready = ->
  loadIndex(boot)
$(document).ready(ready)
$(document).on('page:load', ready)
