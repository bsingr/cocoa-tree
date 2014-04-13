@CategoriesView = Backbone.View.extend
  template: JST['templates/categories']
  el: '#main-view'
  render: (categories) ->
    html = @template
      categories: categories
      i18n: new I18n()
    @$el.html(html)
    @