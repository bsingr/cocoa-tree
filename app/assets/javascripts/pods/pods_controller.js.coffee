class @PodsController
  delegates: []
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
    
