class @PodsNavigationRenderer
  render: (pods_navigation) ->
    html = JST['templates/pods_navigation'](pods_navigation)
    $('#list_navigator').html(html)
