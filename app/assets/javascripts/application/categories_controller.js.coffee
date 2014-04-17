class @CategoriesController
  totalPodsCount: 0
  constructor: (store) ->
    @store = store
  load: () ->
    @store.countForAll().then (count) =>
      @totalPodsCount = count
    @store.categories()
  render: (categories) ->
    list = []
    for c in categories
      list.push(new Category(c))
    (new CategoriesView).render(list, @totalPodsCount)
  