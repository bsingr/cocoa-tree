class @Navigation
  constructor: () ->
    @foundCategories = []
  categories: () ->
    @foundCategories
  render: (foundCategories) ->
    @foundCategories = foundCategories
    html = JST['templates/navigation'](@)
    $('body').prepend(html)
