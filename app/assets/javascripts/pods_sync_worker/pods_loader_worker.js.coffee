class @PodsLoaderWorker
  constructor: (worker, logger) ->
    @logger = logger
    @worker = worker
    @worker.onmessage = (e) =>
      @.onmessage(e)
  onmessage: (e) ->
    command = e.data.command
    @logger.verbose 'PodsLoaderWorker.onmessage command', command
    if command == 'init'
      new PodsIndex("/seeds").load (podsIndex) =>
        @initLoader(podsIndex.seedsURL, podsIndex.index)
    else if command == 'reload'
      @reload()
  initLoader: (seedsURL, index) ->
    @podsLoader = new PodsLoader(seedsURL, index)
    @podsLoader.delegate = @
  reload: ->
    if @podsLoader
      @podsLoader.loadPods()
  didLoad: (id, pods) ->
    @logger.verbose 'PodsLoaderWorker.didLoad', id
    @worker.postMessage
      command: 'didLoad'
      id: id
      pods: pods
      progress: @podsLoader.progress()
  didLoadAll: () ->
    @logger.verbose 'PodsLoaderWorker.didLoadAll'
    @worker.postMessage
      command: 'didLoadAll'
