class @SeedsSyncController
  delegate: null
  constructor: (store, podsSyncWorkerClient) ->
    @progressBar = new PodsProgressBar()
    @store = store
    @store.delegates.push @
    @podsSyncWorkerClient = podsSyncWorkerClient
    @podsSyncWorkerClient.delegate = @
  sync: () ->
    @podsSyncWorkerClient.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    logger.verbose 'SeedsController#didLoad', chunk_id
    @progressBar.update(@podsSyncWorkerClient.progress)
    @store.update pods
  didLoadAll: ->
    logger.verbose 'SeedsController#didLoadAll'
    @store.updateCategories()
    if @delegate
      @delegate.seedsSyncControllerDidSync()
      