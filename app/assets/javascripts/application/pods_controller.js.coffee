class @PodsController
  index: null
  filterBy: "all"
  sortBy: "stars"
  sortAsc: false
  maxPerPage: 50
  count: 0
  constructor: (store) ->
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
  load: () ->
    countPromise = null
    podsPromise = null
    if @filterBy == 'all'
      countPromise = @store.countPods()
      podsPromise = @store.findPods(@sortBy, @sortAsc, @index, @maxPerPage)
    else
      countPromise = @store.findCategory(@filterBy).then (categories) ->
        if categories.length
          categories[0].cocoa_pods_count
      podsPromise = @store.findPodsByCategory(@filterBy, @sortBy, @sortAsc, @index, @maxPerPage)
    countPromise.then (count) =>
      @count = count
    podsPromise.then (pods) =>
      count: @count
      pods: pods
  render: (totalCount, pods) ->
    $('#main-view').empty()
    podsList = new PodsList(totalCount, pods, @index, @maxPerPage)
    (new PodsNavigationView).render(podsList, @sortBy, @filterBy)
    (new PodsView).render(podsList)
