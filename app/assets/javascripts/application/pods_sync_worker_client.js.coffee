class @PodsSyncWorkerClient
  delegates: []
  constructor: (worker, podsIndex) ->
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
        @loadPods()
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
