class @PodsStore
  records: []
  all: ->
    @records
  update: (new_records) ->
    @records = @records.concat(new_records)
    @countAll (c) ->
      console.log c
    @writeObjects(new_records)
  writeObjects: (pods) ->
    @database (db) ->
      t = db.transaction 'pods', 'readwrite'
      s = t.objectStore('pods')
      for pod in pods
        r = s.put(pod)
  countAll: (callback) ->
    @database (db) ->
      t = db.transaction 'pods', 'readwrite'
      s = t.objectStore('pods')
      r = s.count()
      r.onsuccess = ->
        callback(r.result)
  database: (callback) ->
    r = indexedDB.open('pods', 1)
    r.onupgradeneeded = (e) ->
      db = event.target.result
      if !db.objectStoreNames.contains 'pods'
        store = db.createObjectStore 'pods',
          keyPath: 'name'
        store.createIndex "stars", "stars",
          unique: false
    r.onsuccess = (e) ->
      db = r.result
      callback(db)