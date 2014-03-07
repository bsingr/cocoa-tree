# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  podsController = new PodsController
  podsController.loadPods()
  window.podsController = podsController
  window.podsFilterRenderer = new PodsFilterRenderer(podsController)
  window.podsNavigation = new PodsNavigation(podsController)
  new AppRouter()
  Backbone.history.start()
$(document).ready(ready)
$(document).on('page:load', ready)
