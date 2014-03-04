class @PodsNavigation
  constructor: (podsController) ->
    @podsController = podsController
    @podsController.delegate = @
    @pods_list = new PodsList(podsController)
    @render()
  render: ->
    (new PodsRenderer).renderPods(@pods_list.pods())
    (new PodsNavigationRenderer).render(@pods_list)
  pods: (idx) ->
    @pods_list.update(idx)
    @render()
  podsDidChange: ->
    @render()
    