#= require lunr.js
class @AppController
  current: null
  constructor: (seedsWorkerClient, store) ->
    @store = store
    @store.delegates.push @
    @podsController = new PodsController(@store)
    @categoriesController = new CategoriesController(@store)
    @seedsSyncController = new SeedsSyncController(@store, seedsWorkerClient)
    navigation = new Navigation()
    navigation.render()
    @renderEmptyView()
  loadPods: ->
    @seedsSyncController.sync()
  storeDidUpdateCategories: () ->
    @update()
  seedsSyncControllerDidSync: () ->
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
        @podsController.render(result.count, result.pods)
      else
        @renderEmptyView()
  displayCategories: () ->
    @current = 'categories'
    @categoriesController.load().then (categories) =>
      if categories.length
        @categoriesController.render(categories)
      else
        @renderEmptyView()
  displayAbout: () ->
    @current = 'about'
    new AboutView().render()
  displayContribute: () ->
    @current = 'contribute'
    new ContributeView().render()
  renderEmptyView: () ->
    (new EmptyView).render()
