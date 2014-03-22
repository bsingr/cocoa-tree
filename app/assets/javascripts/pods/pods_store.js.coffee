class @PodsStore
  update: (new_records) ->
    @writeObjects(new_records)
  readObjects: (sortBy, asc=true, offset=0, limit=50) ->
    promise = new Promise (resolve, reject) =>
      @database().then (db) ->
        records = []
        t = db.transaction 'pods', 'readonly'
        store = t.objectStore('pods')
        base = store
        if sortBy == 'stars'
          base = base.index('stars')
        direction = if asc then 'next' else 'prev'
        cursorPositionMoved = false
        r = base.openCursor(null, direction)
        r.onsuccess = (e) ->
          cursor = e.target.result
          if cursor
            if cursorPositionMoved
              records.push(cursor.value)
              if records.length == limit
                resolve(records)
              else
                cursor.continue()
            else
              cursorPositionMoved = true
              cursor.advance(offset+1)
          else # no more left
            resolve(records)
        r.onerror = (e) ->
          reject(e)
    promise
  writeObjects: (pods) ->
    @database().then (db) ->
      t = db.transaction 'pods', 'readwrite'
      s = t.objectStore('pods')
      for pod in pods
        r = s.put(pod)
  countAll: () ->
    promise = new Promise (resolve, reject) =>
      @database().then (db) ->
        t = db.transaction 'pods', 'readonly'
        s = t.objectStore('pods')
        r = s.count()
        r.onsuccess = ->
          resolve(r.result - 1)
        r.onerror = ->
          reject(e)
    promise
  database: () ->
    new Promise (resolve, reject) =>
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
        resolve(db)
      r.onerror = (e) ->
        reject(e)