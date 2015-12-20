#= require lunr.js
class @AppController
  current: null
  constructor: (seedsWorkerClient, store) ->
    @store = store
    @store.delegates.push @
    @podsController = new PodsController(@store)
    @categoriesController = new CategoriesController(@store)
    @seedsSyncController = new SeedsSyncController(@store, seedsWorkerClient)
    @seedsSyncController.delegate = @
    navigation = new Navigation()
    navigation.render()
    @renderEmptyView()
  loadPods: ->
    @seedsSyncController.sync()
  seedsSyncControllerDidSyncCategories: () ->
    @update()
  seedsSyncControllerDidSyncPods: () ->
    @update()
  update: () ->
    logger.verbose 'AppController#update current=', @current
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
  displayPod: (id) ->
    logger.verbose 'AppController#displayPod', id
    @store.findPod(id).then (pods) ->
      if pods.length
        $('#main-view').empty()
        podsList = new PodsList(1, pods, 0, 1)
        (new PodsView).render(podsList)
      else
        renderEmptyView()
  displayPods: ->
    logger.verbose 'AppController#displayPods'
    @current = 'pods'
    @podsController.load().then (result) =>
      if result.pods.length
        @podsController.render(result.pods.length, result.pods)
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
