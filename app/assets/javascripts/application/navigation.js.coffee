class @Navigation
  render: (categories) ->
    html = JST['templates/navigation']
      categories: categories
      i18n: new I18n()
    $('body').prepend(html)
