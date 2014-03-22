class @PodsController
  delegates: []
  index: null
  filterBy: "all"
  sortBy: "stars"
  sortAsc: false
  maxPerPage: 50
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
  render: (totalCount, pods) ->
    filteredPods = new PodsFilter(@filterBy).filter(pods)
    podsList = new PodsList(totalCount, filteredPods, @index, @maxPerPage)
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
    countAll = @store.countAll()
    readPage = @store.readObjects(@sortBy, @sortAsc, @index, @maxPerPage)
    Promise.all([countAll, readPage]).then (results) =>
      totalCount = results[0]
      currentPods = results[1]
      $('.pods-count').text(totalCount)
      @render(totalCount, currentPods)
