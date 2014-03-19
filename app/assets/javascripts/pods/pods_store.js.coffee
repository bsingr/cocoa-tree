class @PodsStore
  update: (new_records) ->
    @writeObjects(new_records)
  all: ->
    records = []
    promise = new Promise (resolve, reject) =>
      @database (db) ->
        t = db.transaction 'pods', 'readwrite'
        store = t.objectStore('pods')
        keyRange = IDBKeyRange.lowerBound(0)
        r = store.openCursor(keyRange)
        r.onsuccess = (e) ->
          cursor = e.target.result
          if cursor
            records.push cursor.value
            cursor.continue()
          else
            resolve(records)
        r.onerror = (e) ->
          reject(e)
    promise
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