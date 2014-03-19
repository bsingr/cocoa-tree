class @PodsList
  index: 0
  max_per_page: 50
  constructor: (allPods) ->
    @allPods = allPods
  pods: ->
    @allPods[@index..(@index+@max_per_page-1)]
  has_next: ->
    @next_offset() < @allPods.length
  has_prev: ->
    @index > 0
  next_offset: ->
    @index + @max_per_page
  previous_offset: ->
    @index - @max_per_page
