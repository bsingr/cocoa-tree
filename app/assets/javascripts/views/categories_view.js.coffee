@CategoriesView = Backbone.View.extend
  template: JST['templates/categories']
  el: '#main-view'
  render: (categories) ->
    html = @template
      categories: categories
    @$el.html(html)
    @