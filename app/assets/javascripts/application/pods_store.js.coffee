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
      }]
    @db = new ydn.db.Storage 'pods', stores: [podsSchema]
  update: (new_records) ->
    @writeObjects(new_records)
  readObjects: (sortBy, asc=true, offset=0, limit=50) ->
    logger.verbose 'PodsStore#readObjects'
    if sortBy == 'stars'
      logger.verbose 'sortBy=stars'
      @db.values 'pod', sortBy, null, limit, offset, !asc
    else
      logger.verbose 'sortBy=default'
      @db.values 'pod', null, limit, offset, !asc
  writeObjects: (pods) ->
    @db.put('pod', pods)
  countAll: () ->
    @db.count('pod')
