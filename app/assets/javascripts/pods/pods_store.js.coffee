class @PodsStore
  records: []
  all: ->
    @records
  update: (new_records) ->
    @records = @records.concat(new_records)
    @writeObjects(new_records)
  writeObjects: (pods) ->
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
      t = db.transaction 'pods', 'readwrite'
      s = t.objectStore('pods')
      for pod in pods
        r = s.put(pod)
  