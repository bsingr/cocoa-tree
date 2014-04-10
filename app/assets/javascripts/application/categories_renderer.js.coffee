class @CategoriesRenderer
  render: (categories) ->
    html = JST['templates/categories']
      categories: categories
      i18n: new I18n()
    $('#main-view').html(html)
