@PodsNavigationView = Backbone.View.extend
  template: JST['templates/pods_navigation']
  el: '#main-view'
  render: (podsList, sortBy, filterBy) ->
    obj = 
      podsList: podsList
      sortBy: sortBy
      filterBy: filterBy
    html = (obj)
    $(@el).append(@template(obj))
    @
