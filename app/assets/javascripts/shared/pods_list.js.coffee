define (require) ->
  class PodsList
    constructor: (totalCount, currentPods, index, maxPerPage) ->
      @totalCount = totalCount
      @currentPods = currentPods
      @maxPerPage = maxPerPage
      @index = index
    pods: ->
      @currentPods
    has_next: ->
      @next_offset() < @totalCount
    has_prev: ->
      @index > 0
    next_offset: ->
      @index + @maxPerPage
    previous_offset: ->
      @index - @maxPerPage
