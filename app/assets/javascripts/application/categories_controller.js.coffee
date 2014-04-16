class @CategoriesController
  constructor: (store) ->
    @store = store
  load: () ->
    @store.categories()
  render: (categories) ->
    list = []
    for c in categories
      list.push(new Category(c))
    (new CategoriesView).render(list)