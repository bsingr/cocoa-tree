define (require) ->
  Promise = require 'bluebird'
  require 'ydn'
  Logger = require 'shared/logger'
  logger = new Logger('app', 'info')
  
  class PodsStore
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
        iterator = new ydn.db.IndexValueIterator('pod', sortBy, null, !asc)
      else
        logger.verbose 'sortBy=default'
        iterator = new ydn.db.ValueIterator('pod', null, !asc)
      @db.values iterator, limit
    writeObjects: (pods) ->
      @db.put('pod', pods)
    countAll: () ->
      @db.count('pod')
