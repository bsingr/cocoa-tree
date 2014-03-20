class @PodsFilter
  constructor: (filterBy) ->
    @filterBy = filterBy
  filter: (allPods) ->
    if @filterBy == "all"
      allPods
    else
      pods = []
      for pod in allPods
        base = pod.summary.toLowerCase()
        if base == @filterBy || base.match(" "+@filterBy+" ")
          pods.push(pod)
      pods
      