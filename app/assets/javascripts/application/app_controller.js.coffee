#= require lunr.js
class @AppController
  delegates: []
  current: null
  index: null
  filterBy: "all"
  sortBy: "stars"
  sortAsc: false
  maxPerPage: 50
  count: 0
  constructor: (podsSyncWorkerClient, store) ->
    @store = store
    @store.delegates.push @
    @progressBar = new PodsProgressBar()
    @podsSyncWorkerClient = podsSyncWorkerClient
    @podsSyncWorkerClient.delegate = @
    @search = lunr ->
      @field('name', {boost: 10})
      @field('summary')
      @ref('name')
    navigation = new Navigation()
    navigation.render()
    @renderEmptyView()
  loadPods: ->
    @podsSyncWorkerClient.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    logger.verbose 'AppController#didLoad', chunk_id
    @progressBar.update(@podsSyncWorkerClient.progress)
    @store.update pods
    for pod in pods
      @search.add pod
    for delegate in @delegates
      if delegate.podsDidChange
        delegate.podsDidChange()
  didLoadAll: ->
    @store.updateCategories()
    @update()
  didUpdate: () ->
    @update()
  update: () ->
    logger.verbose 'AppController#update'
    if @current == 'categories'
      @displayCategories()
    else if @current == 'pods'
      @displayPods()
  renderPods: (totalCount, pods) ->
    podsList = new PodsList(totalCount, pods, @index, @maxPerPage)
    @resetMainView()
    (new PodsNavigationView).render(podsList, @sortBy, @filterBy)
    (new PodsView).render(podsList)
  displayPodsAndUpdateScope: (index, filterBy, sortBy) ->
    @current = 'pods'
    @index = index
    @filterBy = filterBy
    @sortBy = sortBy
    if sortBy == 'stars'
      @sortAsc = false
    else if sortBy == 'pushed_at'
      @sortAsc = false
    else
      @sortAsc = true
    @displayPods()
  displayPods: ->
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
    podsPromise.then (pods) =>
      if pods.length
        @renderPods(@count, pods)
      else
        @renderEmptyView()
  displayCategories: () ->
    @current = 'categories'
    @store.categories().then (categories) =>
      if categories.length
        @renderCategoriesView(categories)
      else
        @renderEmptyView()
  renderCategoriesView: (categories) ->
    @resetMainView()
    list = []
    for c in categories
      list.push(new Category(c))
    (new CategoriesView).render(list)
  renderEmptyView: () ->
    @resetMainView()
    (new EmptyView).render()
  resetMainView: () ->
    $('#main-view').empty()