class @SeedsSyncController
  delegate: null
  constructor: (store, seedsWorkerClient) ->
    @progressBar = new PodsProgressBar()
    @store = store
    @store.delegates.push @
    @seedsWorkerClient = seedsWorkerClient
    @seedsWorkerClient.delegate = @
  sync: () ->
    logger.verbose 'SeedsController#sync'
    @seedsWorkerClient.loadPods()
    @progressBar.start()
  didLoadCategories: (index) ->
    logger.verbose 'SeedsController#didLoadCategories', index
    @store.updateCategories(index)
    if @delegate
      @delegate.seedsSyncControllerDidSync()
  didLoad: (chunk_id, pods) ->
    logger.verbose 'SeedsController#didLoad', chunk_id
    @progressBar.update(@seedsWorkerClient.progress)
    @store.updatePods pods
  didLoadAll: ->
    logger.verbose 'SeedsController#didLoadAll'
    if @delegate
      @delegate.seedsSyncControllerDidSync()
