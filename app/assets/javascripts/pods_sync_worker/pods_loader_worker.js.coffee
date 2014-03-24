define (require) ->
  Logger = require 'lib/logger'
  logger = new Logger('worker', 'info')
  PodsLoader = require 'pods/pods_loader'
  class PodsLoaderWorker
    constructor: (worker) ->
      @worker = worker
      @worker.onmessage = (e) =>
        @.onmessage(e)
    onmessage: (e) ->
      command = e.data.command
      logger.verbose 'PodsLoaderWorker.onmessage command', command
      if command == 'init'
        @initLoader(e.data.index)
      else if command == 'reload'
        @reload()
    initLoader: (index) ->
      @podsLoader = new PodsLoader(index)
      @podsLoader.delegate = @
    reload: ->
      @podsLoader.loadPods()
    didLoad: (id, pods) ->
      logger.verbose 'PodsLoaderWorker.didLoad', id
      @worker.postMessage
        command: 'didLoad'
        id: id
        pods: pods
        progress: @podsLoader.progress()
    didLoadAll: () ->
      logger.verbose 'PodsLoaderWorker.didLoadAll'
      @worker.postMessage
        command: 'didLoadAll'
