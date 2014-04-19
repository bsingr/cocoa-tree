class @SeedsWorkerClient
  delegates: []
  constructor: (worker) ->
    @worker = worker
    @worker.onmessage = (e) =>
      command = e.data.command
      if command == 'didLoad'
        @progress = e.data.progress
        @didLoad(e.data.id, e.data.pods)
      else if command == 'didLoadAll'
        @didLoadAll()
      else if command == 'ready'      
        @worker.postMessage
          command: 'init'
      else if command == 'didInitCategories'
        @didLoadCategories(e.data.index)
      else if command == 'didInitPodsLoader'
        @loadPods()
  didLoadCategories: (index) ->
    if @delegate && @delegate.didLoadCategories
      @delegate.didLoadCategories(index)
  loadPods: () ->
    @progress = 0
    @worker.postMessage
      command: 'reload'
  didLoad: (chunk_id, pods) ->
    if @delegate && @delegate.didLoad
      @delegate.didLoad(chunk_id, pods)
  didLoadAll: ->
    if @delegate && @delegate.didLoadAll
      @delegate.didLoadAll()
