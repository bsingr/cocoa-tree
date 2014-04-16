#= require lunr.js
class @AppController
  delegates: []
  current: null
  constructor: (podsSyncWorkerClient, store) ->
    @store = store
    @store.delegates.push @
    @podsController = new PodsController(@store)
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
    else if @current == 'about'
      @displayAbout()
    else if @current == 'contribute'
      @displayContribute()
  displayPodsAndUpdateScope: (index, filterBy, sortBy) ->
    @podsController.updateScope(filterBy, sortBy, index)
    @displayPods()
  displayPods: ->
    logger.verbose 'AppController#displayPods'
    @current = 'pods'
    @podsController.load().then (result) =>
      if result.pods.length
        @resetMainView()
        @podsController.render(result.count, result.pods)
      else
        @renderEmptyView()
  displayCategories: () ->
    @current = 'categories'
    @store.categories().then (categories) =>
      if categories.length
        @renderCategoriesView(categories)
      else
        @renderEmptyView()
  displayAbout: () ->
    @current = 'about'
    new AboutView().render()
  displayContribute: () ->
    @current = 'contribute'
    new ContributeView().render()
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
