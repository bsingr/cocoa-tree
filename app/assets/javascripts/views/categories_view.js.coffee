@CategoriesView = Backbone.View.extend
  template: JST['templates/categories']
  el: '#main-view'
  render: (categories, totalPodsCount) ->
    html = @template
      categories: categories
      totalPodsCount: totalPodsCount
    @$el.html(html)
    @