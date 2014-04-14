@PodsNavigationView = Backbone.View.extend
  template: JST['templates/pods_navigation']
  el: '#main-view'
  render: (podsList, sortBy, filterBy) ->
    sortByList = [{
        name: 'stars'
        displayName: 'Popularity'
      },{
        name: 'pushed_at'
        displayName: 'Activity'
      },{
        name: 'name'
        displayName: 'Name'
      }]
    obj = 
      podsList: podsList
      sortBy: sortBy
      sortByList: sortByList
      filterBy: filterBy
    html = (obj)
    @$el.append(@template(obj))
    @
