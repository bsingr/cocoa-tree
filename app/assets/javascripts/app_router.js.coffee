@AppRouter = Backbone.Router.extend
  routes:
    "reload": "reload"
    "pods/:filter": "pods"
    "pods/:filter/:idx": "pods"
  pods: (filter, idx) ->
    if !idx
      idx = 0
    window.podsNavigation.pods(parseInt(idx), filter)
  reload: ->
    window.podsController.loadPods()
