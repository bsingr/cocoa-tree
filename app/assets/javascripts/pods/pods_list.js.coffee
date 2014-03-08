class @PodsList
  index: 0
  max_per_page: 50
  dirty: true
  constructor: (pods_controller) ->
    @pods_controller = pods_controller
    @pods_filter = new PodsFilter(pods_controller)
    @sorter = new PodsSorter()
  all_pods: ->
    if @dirty || @sorter.dirty || @pods_filter.dirty
      if @dirty || @pods_filter.dirty
        @cached_filtered_pods = @pods_filter.pods()
      @cached_sorted_pods = @sorter.sort(@cached_filtered_pods)
    @cached_sorted_pods
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
  update: (idx, filter, sort_by) ->
    @index = idx
    @pods_filter.set_filter(filter)
    @sorter.set_sort_by(sort_by)
