class @PodsNavigation
  constructor: (podsController) ->
    @podsController = podsController
    @podsController.delegates.push(@)
    @pods_list = new PodsList(podsController)
    @render()
  render: ->
    (new PodsRenderer).renderPods(@pods_list.pods())
    (new PodsNavigationRenderer).render(@pods_list)
  pods: (idx, filter) ->
    @pods_list.update(idx, filter)
    @render()
  podsDidChange: ->
    @render()
    