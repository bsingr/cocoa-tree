class @PodsController
  delegates: []
  pods: []
  constructor: ->
    @progressBar = new PodsProgressBar()
    @loader = new PodsLoader()
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
    
