class @Navigation
  categories: () ->
    [{
      name: 'Graphics'
    },
    {
      name: 'API'
    }]
  render: () ->
    html = JST['templates/navigation'](@)
    $('body').prepend(html)
