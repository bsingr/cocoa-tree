class @SeedsWorker
  constructor: (worker, logger) ->
    @logger = logger
    @worker = worker
    @worker.onmessage = (e) =>
      @.onmessage(e)
    @worker.postMessage
      command: 'ready'
  onmessage: (e) ->
    command = e.data.command
    @logger.verbose 'SeedsWorker.onmessage command', command
    if command == 'init'
      @initIndex()
    else if command == 'reload'
      @reload()
  initIndex: () ->
    new SeedsIndex("/seeds/categories").load (index) =>
      @initCategories(index.index)
    new SeedsIndex("/seeds/pods").load (index) =>
      @initPodsLoader(index.seedsURL, index.index)
  initCategories: (index) ->
    @worker.postMessage
      command: 'didInitCategories'
      index: index
  initPodsLoader: (seedsURL, index) ->
    @podsLoader = new PodsLoader(seedsURL, index)
    @podsLoader.delegate = @
    @worker.postMessage
      command: 'didInitPodsLoader'
  reload: ->
    if @podsLoader
      @podsLoader.loadPods()
  didLoad: (id, pods) ->
    @logger.verbose 'SeedsWorker.didLoad', id
    @worker.postMessage
      command: 'didLoad'
      id: id
      pods: pods
      progress: @podsLoader.progress()
  didLoadAll: () ->
    @logger.verbose 'SeedsWorker.didLoadAll'
    @worker.postMessage
      command: 'didLoadAll'
