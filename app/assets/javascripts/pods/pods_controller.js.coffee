class @PodsController
  delegates: []
  constructor: (loader, store) ->
    @store = store
    @progressBar = new PodsProgressBar()
    @loader = loader
    @loader.delegate = @
    @pods_filter = new PodsFilter(store)
    @pods_list = new PodsList(@pods_filter)
    @render()
  loadPods: ->
    @loader.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    @progressBar.update(@loader.progress())
    @store.update pods
    @pods_list.dirty = true
    @render()
    for delegate in @delegates
      if delegate.podsDidChange
        delegate.podsDidChange()
  didLoadAll: ->
    
  render: ->
    (new PodsRenderer).renderPods(@pods_list.pods())
    (new PodsNavigationRenderer).render(@pods_list)
  changeScope: (idx, filter, sort_by) ->
    @pods_list.update(idx, filter, sort_by)
    @render()
    
