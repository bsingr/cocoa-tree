class @PodsNavigation
  constructor: (podsController, store) ->
    @podsController = podsController
    @podsController.delegates.push(@)
    @pods_filter = new PodsFilter(store)
    @pods_list = new PodsList(@pods_filter)
    @render()
  render: ->
    (new PodsRenderer).renderPods(@pods_list.pods())
    (new PodsNavigationRenderer).render(@pods_list)
  pods: (idx, filter, sort_by) ->
    @pods_list.update(idx, filter, sort_by)
    @render()
  podsDidChange: ->
    @pods_list.dirty = true
    @render()
    