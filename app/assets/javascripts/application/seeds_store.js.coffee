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
        keyPath: 'category'
      }]
    categoriesSchema =
      name: 'category'
      keyPath: 'name'
      type: 'TEXT'
      indexes: []
    @db = new ydn.db.Storage name, stores: [podsSchema, categoriesSchema]
  clear: () ->
    @db.clear()
  update: (new_records) ->
    @writeObjects(new_records)
  # this reads only pods within one category and must implement sorting and
  # pagination itself
  readFromCategory: (category, sortBy, asc=true, offset=0, limit=50) ->
    logger.verbose 'PodsStore#readCategory'
    keyRange = ydn.db.KeyRange.only(category)
    @db.values('pod', 'category', keyRange).then (allPods) ->
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
  readPod: (name) ->
    keyRange = ydn.db.KeyRange.only(name)
    @db.values 'pod', keyRange
  writeObjects: (pods) ->
    @db.put('pod', pods)
  countForCategory: (category) ->
    keyRange = ydn.db.KeyRange.only(category)
    @db.count('pod', 'category', keyRange)
  countForAll: () ->
    @db.count('pod')
  updateCategories: (categories) ->
    @db.clear('category')
    @db.put('category', categories)
    @didUpdateCategories()
    categories
  categories: () ->
    @db.values 'category'
  didUpdateCategories: () ->
    for delegate in @delegates
      if delegate.storeDidUpdateCategories
        delegate.storeDidUpdateCategories()
