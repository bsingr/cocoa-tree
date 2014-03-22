class @PodsController
  delegates: []
  index: null
  filterBy: "all"
  sortBy: "stars"
  sortAsc: false
  constructor: (podsSyncWorkerClient, store) ->
    @store = store
    @progressBar = new PodsProgressBar()
    @podsSyncWorkerClient = podsSyncWorkerClient
    @podsSyncWorkerClient.delegate = @
    @search = lunr ->
      @field('name', {boost: 10})
      @field('summary')
      @ref('name')
  loadPods: ->
    @podsSyncWorkerClient.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    logger.verbose 'PodsController#didLoad', chunk_id
    @progressBar.update(@podsSyncWorkerClient.progress)
    @store.update pods
    for pod in pods
      @search.add pod
    for delegate in @delegates
      if delegate.podsDidChange
        delegate.podsDidChange()
  didLoadAll: ->
    logger.verbose 'PodsController#didLoadAll'
  render: (pods) ->
    filteredPods = new PodsFilter(@filterBy).filter(pods)
    podsList = new PodsList(filteredPods)
    podsList.index = @index
    (new PodsRenderer).renderPods(podsList.pods())
    (new PodsNavigationRenderer).render(podsList, @sortBy, @filterBy)
    (new PodsFilterRenderer).render(pods)
  changeScope: (index, filterBy, sortBy) ->
    @index = index
    @filterBy = filterBy
    @sortBy = sortBy
    @sortAsc = if (sortBy == 'stars') then false else true
    @update()
  update: ->
    @store.countAll().then (count) ->
      $('.pods-count').text(count)
    @store.all(@sortBy, @sortAsc).then (pods) =>
      @render(pods)