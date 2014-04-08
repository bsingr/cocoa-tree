class @Navigation
  constructor: () ->
    @foundCategories = []
    @i18n = new I18n()
  categories: () ->
    @foundCategories
  render: (foundCategories) ->
    @foundCategories = foundCategories
    html = JST['templates/navigation'](@)
    $('body').prepend(html)
