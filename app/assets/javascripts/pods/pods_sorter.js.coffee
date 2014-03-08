class @PodsSorter
  sort_by: null
  sort: (pods) ->
    if @sort_by
      sort_by = @sort_by
      pods.sort (a,b) ->
        a[sort_by] - b[sort_by]
    else
      pods.sort (a,b) ->
        a - b
