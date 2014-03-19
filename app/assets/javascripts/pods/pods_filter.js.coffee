class @PodsFilter
  constructor: (filterBy) ->
    @filterBy = filterBy
  filter: (allPods) ->
    if @filterBy == "all"
      allPods
    else
      pods = []
      for pod in allPods
        if pod.summary.toLowerCase().match(" "+@filterBy+" ")
          pods.push(pod)
      pods
      