class @PodsIndex
  constructor: (storeURL) ->
    @storeURL = storeURL
  load: (callback) ->
    podsIndex = @
    xhr = new XMLHttpRequest()
    xhr.open('GET', @storeURL+'/pods.mpac', true)
    xhr.responseType = 'arraybuffer'
    xhr.onload = (e) ->
      podsIndex.index = msgpack.decode(@response)
      callback(podsIndex)
    xhr.send()
