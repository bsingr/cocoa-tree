class @PodsController
  delegates: []
  pods: []
  constructor: (loader) ->
    @progressBar = new PodsProgressBar()
    @loader = loader
    @loader.delegate = @
  loadPods: ->
    @pods = []
    @loader.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    @progressBar.update(@loader.progress())
    @pods = @pods.concat(pods)
    for delegate in @delegates
      if delegate.podsDidChange
        delegate.podsDidChange()
  didLoadAll: ->
    
