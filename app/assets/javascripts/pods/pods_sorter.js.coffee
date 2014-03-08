class @PodsSorter
  sort_by: null
  sort: (pods) ->
    if @sort_by
      sort_by = @sort_by
      pods.sort (a,b) ->
        a_value = a[sort_by]
        b_value = b[sort_by]
        if typeof(a_value) == 'string' && typeof(b_value) == 'string'
          if a_value.toLowerCase() >= b_value.toLowerCase()
            1
          else
            -1
        else if typeof(a_value) == 'number' && typeof(b_value) == 'number'
          a_value - b_value
        else if typeof(a_value) == 'number' && typeof(b_value) == 'string'
          -1
        else if typeof(a_value) == 'string' && typeof(b_value) == 'number'
          1
        else if typeof(a_value) == 'object' && typeof(b_value) == 'object'
          -1
        else if typeof(a_value) == 'object'
          1
        else
          -1
    else
      pods.sort (a,b) ->
        a - b
