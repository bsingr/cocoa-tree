class @PodsSorter
  sort: (pods) ->
    if @sort_by
      sort_by = @sort_by
      sorter = @
      pods.sort (a,b) ->
        av = a[sort_by]
        bv = b[sort_by]
        sorter._sort(av, bv)
    else
      pods.sort @._sort
  _sort: (a,b) ->
    if typeof(a) == 'string' && typeof(b) == 'string'
      if a.toLowerCase() > b.toLowerCase()
        1
      else
        -1
    else if typeof(a) == 'number' && typeof(b) == 'number'
      b - a
    else if typeof(a) == 'number' && typeof(b) == 'string'
      -1
    else if typeof(a) == 'string' && typeof(b) == 'number'
      1
    else if typeof(a) == 'object' && typeof(b) == 'object'
      -1
    else if typeof(a) == 'object'
      1
    else
      -1
