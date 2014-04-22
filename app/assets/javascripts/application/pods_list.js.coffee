class @PodsList
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
  paginationPosition: (index) ->
    innerPadding = 2
    outerPadding = 1
    if index == @index
      'current'
    else if index > @index
      barrier = (@index + innerPadding*@maxPerPage)
      if index < barrier || index > (@totalCount - outerPadding*@maxPerPage)
        'within'
      else if index == barrier
        'barrier'
      else
        'without'
    else if index < @index
      barrier = (@index - innerPadding*@maxPerPage)
      if index > barrier || index < outerPadding*@maxPerPage
        'within'
      else if index == barrier
        'barrier'
      else
        'without'




