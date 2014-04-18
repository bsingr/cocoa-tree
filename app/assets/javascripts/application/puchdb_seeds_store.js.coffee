#= require pouchdb.js
class @PouchDbSeedsStore
  delegates: []
  constructor: (name='seeds') ->
    @name = name
    @initDb()
  initDb: ->
    @db = new PouchDB(@name)
  clear: () ->
    @db.destroy().then (err, info) =>
      @initDb()
      [err, info]
  update: (new_records) ->
    @writeObjects(new_records)
  # this reads only pods within one category and must implement sorting and
  # pagination itself
  readFromCategory: (category, sortBy, asc=true, offset=0, limit=50) ->
    logger.verbose 'PodsStore#readCategory'
    #keyRange = ydn.db.KeyRange.only(category)
    keyRange = null
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
    p = @db.allDocs
      include_docs: true
      descending: !asc
      limit: limit
      skip: offset
    p.then (r) ->
      docs = []
      for row in r.rows
        docs.push row.doc
      docs
  readPod: (name) ->
    @db.get(name).then (doc) ->
      [doc]
  writeObjects: (pods) ->
    for pod in pods
      pod._id = pod.name
    @db.bulkDocs
      docs: pods
  countForCategory: (category) ->
    #keyRange = ydn.db.KeyRange.only(category)
    keyRange = null
    @db.count('pod', 'category', keyRange)
  countForAll: () ->
    map = (doc, emit) ->
      if doc.category
        emit(doc.name, null)
    promise = @db.query
      map: map
      reduce: '_count'
    promise.then (result) ->
      result.total_rows
  updateCategories: () ->
    # iterator = new ydn.db.IndexValueIterator('pod', 'category', null, false, false)
    iterator = null
    @db.values(iterator).then (pods) =>
      categories = {}
      for pod in pods
        category = categories[pod.category]
        if category
          category.podsCount++
        else
          categories[pod.category] =
            podsCount: 1
            name: pod.category
      categoriesArray = []
      for categoryName, category of categories
        categoriesArray.push category
      @db.clear('category')
      @db.put('category', categoriesArray)
      @didUpdateCategories()
      categories
  categories: () ->
    @db.values 'category'
  didUpdateCategories: () ->
    for delegate in @delegates
      if delegate.storeDidUpdateCategories
        delegate.storeDidUpdateCategories()
