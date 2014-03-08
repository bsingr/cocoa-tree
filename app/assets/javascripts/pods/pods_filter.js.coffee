class @PodsFilter
  filter: "all"
  dirty: true
  set_filter: (filter) ->
    if filter != @filter
      @dirty = true
      @filter = filter
  constructor: (pods_controller) ->
    @pods_controller = pods_controller
  pods: ->
    @dirty = false
    if @filter == "all"
      @pods_controller.pods
    else
      pods = []
      for pod in @pods_controller.pods
        if pod.summary.toLowerCase().match(" "+@filter+" ")
          pods.push(pod)
      pods  