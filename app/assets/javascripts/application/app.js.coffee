loadIndex = (callback) ->
  xhr = new XMLHttpRequest()
  xhr.open('GET', '/pods.mpac', true)
  xhr.responseType = 'arraybuffer'
  xhr.onload = (e) ->
    index = msgpack.decode(@response)
    callback(index)
  xhr.send()

boot = (index) ->
  podsStore = new PodsStore()
  podsLoader = new PodsLoader(index)
  podsController = new PodsController(podsLoader, podsStore)
  podsController.loadPods()
  window.podsController = podsController
  window.podsFilterRenderer = new PodsFilterRenderer(podsController, podsStore)
  window.podsNavigation = new PodsNavigation(podsController, podsStore)
  new AppRouter()
  Backbone.history.start()
ready = ->
  loadIndex(boot)
$(document).ready(ready)
$(document).on('page:load', ready)
