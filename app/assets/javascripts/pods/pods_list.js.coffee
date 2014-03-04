class @PodsList
  index: 0
  max_per_page: 50
  constructor: (pods_controller) ->
    @pods_controller = pods_controller
  all_pods: ->
    @pods_controller.pods
  pods: ->
    @all_pods()[@index..(@index+@max_per_page-1)]
  has_next: ->
    (@index + 1) < @all_pods().length
  has_prev: ->
    @index > 0
  next_offset: ->
    @index + @max_per_page
  previous_offset: ->
    @index - @max_per_page
  update: (idx) ->
    @index = idx
    