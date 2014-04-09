#= require ydn.js
class @PodsStore
  constructor: () ->
    @initDb()
  initDb: () ->
    podsSchema = 
      name: 'pod'
      keyPath: 'name'
      type: 'TEXT'
      indexes: [{
        keyPath: 'stars'
      },{
        keyPath: 'pushed_at'
      },{
        keyPath: 'category'
      }]
    categoriesSchema =
      name: 'category'
      keyPath: 'name'
      type: 'TEXT'
      indexes: []
    @db = new ydn.db.Storage 'pods', stores: [podsSchema, categoriesSchema]
  update: (new_records) ->
    @writeObjects(new_records)
  # this reads only pods within one category and must implement sorting and
  # pagination itself
  readFromCategory: (category, sortBy, asc=true, offset=0, limit=50) ->
    logger.verbose 'PodsStore#readCategory'
    keyRange = ydn.db.KeyRange.only(category)
    @db.values('pod', 'category', keyRange).then (allPods) ->
      pods = []
      i = offset
      while i <= (offset + limit) && i < allPods.length
        pod = allPods[i]
        pods.push pod
        i++
      pods
  # this reads from _all_ pods and uses ydn internal capabilities for sorting
  # and pagination
  readFromAll: (sortBy, asc=true, offset=0, limit=50) ->
    logger.verbose 'PodsStore#readPage'
    if sortBy == 'name'
      logger.verbose 'sortBy=name'
      @db.values 'pod', null, limit, offset, !asc
    else
      logger.verbose 'sortBy='+sortBy
      @db.values 'pod', sortBy, null, limit, offset, !asc
  writeObjects: (pods) ->
    @db.put('pod', pods)
  countForCategory: (category) ->
    keyRange = ydn.db.KeyRange.only(category)
    @db.count('pod', 'category', keyRange)
  countForAll: () ->
    @db.count('pod')
  updateCategories: () ->
    iterator = new ydn.db.IndexValueIterator('pod', 'category', null, false, true)
    @db.values(iterator).then (pods) =>
      categories = []
      for pod in pods
        category = pod.category
        if category != ''
          categories.push
            name: category
      @db.put('category', categories)
      categories
  categories: () ->
    @db.values 'category'
