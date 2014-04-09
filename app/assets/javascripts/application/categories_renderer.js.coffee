class @CategoriesRenderer
  render: (categories) ->
    html = JST['templates/categories']
      categories: categories
    $('#main-view').html(html)
