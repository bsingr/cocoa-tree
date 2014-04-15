@AppRouter = Backbone.Router.extend
  routes:
    "reload": "reload"
    "": "categories"
    "about": "about"
    "contribute": "contribute"
    "pods/:filter": "pods"
    "pods/:filter/:sort_by": "pods"
    "pods/:filter/:sort_by/:idx": "pods"
  contribute: () ->
    @appController.displayContribute()
  about: () ->
    @appController.displayAbout()
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
