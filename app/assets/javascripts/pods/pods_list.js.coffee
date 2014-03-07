class @PodsList
  index: 0
  max_per_page: 50
  constructor: (pods_controller) ->
    @pods_controller = pods_controller
    @pods_filter = new PodsFilter(pods_controller)
  all_pods: ->
    @pods_filter.pods()
  pods: ->
    @all_pods()[@index..(@index+@max_per_page-1)]
  has_next: ->
    @next_offset() < @all_pods().length
  has_prev: ->
    @index > 0
  next_offset: ->
    @index + @max_per_page
  previous_offset: ->
    @index - @max_per_page
  update: (idx, filter) ->
    @index = idx
    @pods_filter.filter = filter
    