class @PodsController
  delegates: []
  index: null
  filterBy: "all"
  sortBy: "stars"
  sortAsc: false
  constructor: (loader, store) ->
    @store = store
    @progressBar = new PodsProgressBar()
    @loader = loader
    @loader.delegate = @
    @search = lunr ->
      @field('name', {boost: 10})
      @field('summary')
      @ref('name')
  loadPods: ->
    @loader.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    @progressBar.update(@loader.progress())
    @store.update pods
    for pod in pods
      @search.add pod
    for delegate in @delegates
      if delegate.podsDidChange
        delegate.podsDidChange()
  didLoadAll: ->
    
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
    @store.countAll (count) ->
      $('.pods-count').text(count)
    @store.all(@sortBy, @sortAsc).then (pods) =>
      @render(pods)