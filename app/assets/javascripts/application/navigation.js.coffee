class @Navigation
  render: ->
    html = JST['templates/navigation']()
    $('.navbar-container').html(html)
