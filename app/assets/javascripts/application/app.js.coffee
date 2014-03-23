@logger = new Logger('app')
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
  podsSyncWorker = new Worker('/assets/pods_sync_worker.js')
  podsSyncWorkerClient = new PodsSyncWorkerClient(podsSyncWorker, index)
  window.podsController = new PodsController(podsSyncWorkerClient, podsStore)
  window.podsController.loadPods()
  new AppRouter()
  Backbone.history.start()
ready = ->
  loadIndex(boot)
$(document).ready(ready)
$(document).on('page:load', ready)
