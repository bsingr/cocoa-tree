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
  didLoad: (chunk_id, pods) ->
    logger.verbose 'SeedsController#didLoad', chunk_id
    @progressBar.update(@seedsWorkerClient.progress)
    @store.update pods
  didLoadAll: ->
    logger.verbose 'SeedsController#didLoadAll'
    @store.updateCategories()
    if @delegate
      @delegate.seedsSyncControllerDidSync()
