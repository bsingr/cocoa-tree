class @PodsNavigator
  index: 0
  max_per_page: 50
  constructor: (podsController) ->
    @podsController = podsController
    @podsController.delegate = @
    @render()
  render: ->
    @renderPods()
    (new PodsNavigationRenderer).render(@)
  has_next: ->
    (@index + 1) < gon.pods_count
  has_prev: ->
    @index > 0
  renderPods: ->
    pods = @podsController.pods[@index..(@index+@max_per_page-1)]
    renderer = new PodsRenderer
    renderer.renderPods(pods)
  next: ->
    @index += @max_per_page
    @render()
  prev: ->
    @index -= @max_per_page
    @render()
  next_offset: ->
    @index + @max_per_page
  previous_offset: ->
    @index - @max_per_page
  pods: (idx) ->
    @index = idx
    @render()
  podsDidChange: ->
    @render()
    