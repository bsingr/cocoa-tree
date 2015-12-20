#= require ydn.js
class @SeedsStore
  delegates: []
  constructor: (name='seeds') ->
    @initDb(name)
  initDb: (name) ->
    podsSchema =
      name: 'pod'
      keyPath: 'name'
      type: 'TEXT'
      indexes: [{
        keyPath: 'stars'
      },{
        keyPath: 'pushed_at'
      },{
        keyPath: 'category_name'
      }]
    categoriesSchema =
      name: 'category'
      keyPath: 'name'
      type: 'TEXT'
      indexes: []
    @db = new ydn.db.Storage name, stores: [podsSchema, categoriesSchema]
  clear: () ->
    @db.clear()
  # this reads from _all_ pods and uses ydn internal capabilities for sorting
  # and pagination
  findPods: (sortBy, asc=true, offset=0, limit=50) ->
    logger.verbose 'PodsStore#readPage'
    if sortBy == 'name'
      logger.verbose 'sortBy=name'
      @db.values 'pod', null, limit, offset, !asc
    else
      logger.verbose 'sortBy='+sortBy
      @db.values 'pod', sortBy, null, limit, offset, !asc
  # this reads only pods within one category and must implement sorting and
  # pagination itself
  findPodsByCategory: (category, sortBy, asc=true, offset=0, limit=50) ->
    logger.verbose 'PodsStore#readCategory'
    keyRange = ydn.db.KeyRange.only(category)
    @db.values('pod', 'category_name', keyRange).then (allPods) ->
      sorter = new ObjectSorter()
      sorter.sortBy = sortBy
      allSortedPods = sorter.sort(allPods)
      if asc
        allSortedPods.reverse()
      pods = []
      i = offset
      while i < (offset + limit) && i < allSortedPods.length
        pod = allSortedPods[i]
        pods.push pod
        i++
      pods
  findPod: (name) ->
    keyRange = ydn.db.KeyRange.only(name)
    @db.values 'pod', keyRange
  countPods: () ->
    @db.count('pod')
  updatePods: (pods) ->
    @db.put('pod', pods)
  findCategories: () ->
    iterator = new ydn.db.ValueIterator("category")
    @db.values iterator, 1000
  findCategory: (name) ->
    keyRange = ydn.db.KeyRange.only(name)
    @db.values 'category', keyRange
  updateCategories: (categories) ->
    @db.clear('category')
    @db.put('category', categories)
