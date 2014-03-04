class @PodsController
  delegate: null
  constructor: ->
    @progressBar = new PodsProgressBar()
    @loader = new PodsLoader()
    @loader.delegate = @
  pods: []
  loadPods: ->
    @loader.loadPods()
    @progressBar.start()
  didLoad: (chunk_id, pods) ->
    @progressBar.update(@loader.progress())
    @pods = @pods.concat(pods)
    if @delegate && @delegate.podsDidChange
      @delegate.podsDidChange()
  didLoadAll: ->
    @progressBar.finish()
