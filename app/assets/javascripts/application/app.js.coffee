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
