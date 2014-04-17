@AppRouter = Backbone.Router.extend
  routes:
    "reload": "reload"
    "": "categories"
    "about": "about"
    "contribute": "contribute"
    "pods/:filter": "pods"
    "pods/:filter/:sort_by": "pods"
    "pods/:filter/:sort_by/:idx": "pods"
    "pod/:id": "pod"
  contribute: () ->
    @pageview '/contribute'
    @appController.displayContribute()
  about: () ->
    @pageview '/about'
    @appController.displayAbout()
  categories: () ->
    @pageview '/categories'
    @appController.displayCategories()
  pods: (filter, sort_by, idx) ->
    if !filter
      filter = 'all'
    if !sort_by
      sort_by = 'stars'
    if !idx
      idx = 0
    @pageview '/pods/'+filter+'/'+sort_by+'/'+idx
    @appController.displayPodsAndUpdateScope(parseInt(idx), filter, sort_by)
  pod: (id) ->
    @pageview '/pod/'+id
    @appController.displayPod(id)
  reload: ->
    @appController.loadPods()
    @navigate('/', true)
  pageview: (page) ->
    if window.ga
      window.ga 'send', 'pageview', page