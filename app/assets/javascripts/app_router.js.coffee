@AppRouter = Backbone.Router.extend
  routes:
    "reload": "reload"
    "pods/:filter/:idx": "pods"
  pods: (filter, idx) ->
    window.podsNavigation.pods(parseInt(idx), filter)
  reload: ->
    window.podsController.loadPods()
