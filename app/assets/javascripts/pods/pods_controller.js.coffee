# = require lunr.js

define (require) ->
  Promise = require 'bluebird'
  PodsRenderer = require 'pods/pods_renderer'
  PodsProgressBar = require 'pods/pods_progress_bar'
  PodsFilter = require 'pods/pods_filter'
  PodsList = require 'pods/pods_list'
  PodsNavigationRenderer = require 'pods/pods_navigation_renderer'
  PodsFilterRenderer = require 'pods/pods_filter_renderer'
  class PodsController
    delegates: []
    index: null
    filterBy: "all"
    sortBy: "stars"
    sortAsc: false
    maxPerPage: 50
    count: 0
    constructor: (podsSyncWorkerClient, store) ->
      @store = store
      @progressBar = new PodsProgressBar()
      @podsSyncWorkerClient = podsSyncWorkerClient
      @podsSyncWorkerClient.delegate = @
      @search = lunr ->
        @field('name', {boost: 10})
        @field('summary')
        @ref('name')
    loadPods: ->
      @podsSyncWorkerClient.loadPods()
      @progressBar.start()
    didLoad: (chunk_id, pods) ->
      logger.verbose 'PodsController#didLoad', chunk_id
      @progressBar.update(@podsSyncWorkerClient.progress)
      @store.update pods
      for pod in pods
        @search.add pod
      for delegate in @delegates
        if delegate.podsDidChange
          delegate.podsDidChange()
    didLoadAll: ->
      logger.verbose 'PodsController#didLoadAll'
    render: (totalCount, pods) ->
      filteredPods = new PodsFilter(@filterBy).filter(pods)
      podsList = new PodsList(totalCount, filteredPods, @index, @maxPerPage)
      (new PodsRenderer).renderPods(podsList.pods())
      (new PodsNavigationRenderer).render(podsList, @sortBy, @filterBy)
      (new PodsFilterRenderer).render(pods)
    changeScope: (index, filterBy, sortBy) ->
      @index = index
      @filterBy = filterBy
      @sortBy = sortBy
      @sortAsc = if (sortBy == 'stars') then false else true
      @update()
    update: ->
      logger.verbose 'PodsController#update.start'
      countAll = @store.countAll()
      readPage = @store.readObjects(@sortBy, @sortAsc, @index, @maxPerPage)
      countAll.then (count) =>
        @count = count
        logger.verbose 'PodsController#update.promise', count
        $('.pods-count').text(count)
      readPage.then (pods) =>
        @render(@count, pods)
