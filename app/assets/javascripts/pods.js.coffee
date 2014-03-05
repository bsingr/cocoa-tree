# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  podsController = new PodsController
  podsController.loadPods()
  window.podsNavigation = new PodsNavigation(podsController)
  AppRouter = Backbone.Router.extend
    routes:
      "reload": "reload"
      "pods/:filter/:idx": "pods"
    pods: (filter, idx) ->
      window.podsNavigation.pods(parseInt(idx), filter)
    reload: ->
      podsController.loadPods()
  new AppRouter()
  Backbone.history.start()
$(document).ready(ready)
$(document).on('page:load', ready)
