class @PodsNavigationRenderer
  render: (pods_list) ->
    html = JST['templates/pods_navigation'](pods_list)
    $('#list_navigator').html(html)
