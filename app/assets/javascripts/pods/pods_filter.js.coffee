class @PodsFilter
  filter: "all"
  dirty: true
  set_filter: (filter) ->
    if filter != @filter
      @dirty = true
      @filter = filter
  constructor: (store) ->
    @store = store
  pods: ->
    @dirty = false
    if @filter == "all"
      @store.all()
    else
      pods = []
      for pod in @store.all()
        if pod.summary.toLowerCase().match(" "+@filter+" ")
          pods.push(pod)
      pods
      