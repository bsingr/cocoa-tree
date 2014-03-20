class @PodsController
  delegates: []
  index: null
  filterBy: "all"
  sortBy: "stars"
  constructor: (loader, store) ->
    @store = store
    @progressBar = new PodsProgressBar()
    @loader = loader
    @loader.delegate = @
  loadPods: ->
    @loader.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    @progressBar.update(@loader.progress())
    @store.update pods
    for delegate in @delegates
      if delegate.podsDidChange
        delegate.podsDidChange()
  didLoadAll: ->
    
  render: (pods) ->
    filteredPods = new PodsFilter(@filterBy).filter(pods)
    sortedPods = new PodsSorter(@sortBy).sort(filteredPods)
    podsList = new PodsList(sortedPods)
    podsList.index = @index
    (new PodsRenderer).renderPods(podsList.pods())
    (new PodsNavigationRenderer).render(podsList, @sortBy, @filterBy)
    (new PodsFilterRenderer).render(pods)
  changeScope: (index, filterBy, sortBy) ->
    @index = index
    @filterBy = filterBy
    @sortBy = sortBy
    @update()
  update: ->
    @store.countAll (count) ->
      $('.pods-count').text(count)
    @store.all().then (pods) =>
      @render(pods)