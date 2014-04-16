class @PodsController
  index: null
  filterBy: "all"
  sortBy: "stars"
  sortAsc: false
  maxPerPage: 50
  count: 0
  constructor: (appController, store) ->
    @appController = appController
    @store = store
    @store.delegates.push @
  updateScope: (filterBy, sortBy, index) ->
    @index = index
    @filterBy = filterBy
    @sortBy = sortBy
    if sortBy == 'stars'
      @sortAsc = false
    else if sortBy == 'pushed_at'
      @sortAsc = false
    else
      @sortAsc = true
  display: () ->
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
        @appController.renderPods(@count, pods)
      else
        @appController.renderEmptyView()
