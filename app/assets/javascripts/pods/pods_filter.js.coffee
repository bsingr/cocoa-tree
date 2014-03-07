class @PodsFilter
  filter: "all"
  constructor: (pods_controller) ->
    @pods_controller = pods_controller
  pods: ->
    if @filter == "all"
      @pods_controller.pods
    else
      pods = []
      for pod in @pods_controller.pods
        if pod.summary.toLowerCase().match(" "+@filter+" ")
          pods.push(pod)
      pods  