#= require lunr.js
class @AppController
  delegates: []
  index: null
  filterBy: "all"
  sortBy: "stars"
  sortAsc: false
  maxPerPage: 50
  count: 0
  constructor: (podsSyncWorkerClient, store) ->
    @store = store
    @progressBar = new PodsProgressBar()
    @podsSyncWorkerClient = podsSyncWorkerClient
    @podsSyncWorkerClient.delegate = @
    @search = lunr ->
      @field('name', {boost: 10})
      @field('summary')
      @ref('name')
    @update()
  loadPods: ->
    @podsSyncWorkerClient.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    logger.verbose 'AppController#didLoad', chunk_id
    @progressBar.update(@podsSyncWorkerClient.progress)
    @store.update pods
    @store.updateCategories()
    for pod in pods
      @search.add pod
    for delegate in @delegates
      if delegate.podsDidChange
        delegate.podsDidChange()
  didLoadAll: ->
    logger.verbose 'AppController#didLoadAll'
  render: (totalCount, pods) ->
    podsList = new PodsList(totalCount, pods, @index, @maxPerPage)
    @resetMainView()
    (new PodsNavigationRenderer).render(podsList, @sortBy, @filterBy)
    (new PodsRenderer).renderPods(podsList.pods())
  changeScope: (index, filterBy, sortBy) ->
    @index = index
    @filterBy = filterBy
    @sortBy = sortBy
    if sortBy == 'stars'
      @sortAsc = false
    else if sortBy == 'pushed_at'
      @sortAsc = false
    else
      @sortAsc = true
    @update()
  update: ->
    logger.verbose 'AppController#update.start'
    countPromise = null
    podsPromise = null
    if @filterBy == 'all'
      countPromise = @store.countForAll()
      podsPromise = @store.readFromAll(@sortBy, @sortAsc, @index, @maxPerPage)
    else
      countPromise = @store.countForCategory(@filterBy)
      podsPromise = @store.readFromCategory(@filterBy, @sortBy, @sortAsc, @index, @maxPerPage)
    countPromise.then (count) =>
      @count = count
      logger.verbose 'AppController#update.promise', count
      $('.pods-count').text(count)
    podsPromise.then (pods) =>
      @render(@count, pods)
    @store.categories().then (categories) ->
      (new Navigation).render(categories)
  displayCategories: () ->
    @store.categories().then (categories) =>
      @resetMainView()
      (new CategoriesRenderer).render(categories)
  resetMainView: () ->
    $('#main-view').empty()