@AppRouter = Backbone.Router.extend
  routes:
    "reload": "reload"
    "": "categories"
    "pods/:filter": "pods"
    "pods/:filter/:sort_by": "pods"
    "pods/:filter/:sort_by/:idx": "pods"
  categories: () ->
    @appController.displayCategories()
  pods: (filter, sort_by, idx) ->
    if !filter
      filter = 'all'
    if !sort_by
      sort_by = 'stars'
    if !idx
      idx = 0
    @appController.displayPodsAndUpdateScope(parseInt(idx), filter, sort_by)
  reload: ->
    @appController.loadPods()
