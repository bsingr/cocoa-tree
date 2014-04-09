class @ObjectSorter
  sort: (objects) ->
    if @sortBy
      sortBy = @sortBy
      sorter = @
      objects.sort (a,b) ->
        av = a[sortBy]
        bv = b[sortBy]
        sorter._sort(av, bv)
    else
      objects.sort @._sort
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
