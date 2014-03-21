class @PodsLoaderWorker
  constructor: (worker) ->
    @worker = worker
    @worker.onmessage = (e) =>
      @.onmessage(e)
  onmessage: (e) ->
    command = e.data.command
    if command == 'init'
      @initLoader(e.data.index)
    else if command == 'reload'
      @reload()
  initLoader: (index) ->
    podsLoader = new PodsLoader(index)
    podsLoader.delegate = @
    @podsLoader = podsLoader
  reload: ->
    @podsLoader.loadPods()
  didLoad: (id, pods) ->
    @worker.postMessage
      command: 'didLoad'
      id: id
      pods: pods
      progress: @podsLoader.progress()
  didLoadAll: () ->
    @worker.postMessage
      command: 'didLoadAll'

podsLoaderWorker = new PodsLoaderWorker(@)
