class @PodsNavigationRenderer
  render: (podsList, sortBy, filterBy) ->
    obj = 
      podsList: podsList
      sortBy: sortBy
      filterBy: filterBy
    html = JST['templates/pods_navigation'](obj)
    $('#main-view').append(html)
