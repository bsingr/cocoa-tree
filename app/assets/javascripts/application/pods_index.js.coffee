class @PodsIndex
  constructor: (seedsURL) ->
    @seedsURL = seedsURL
  load: (callback) ->
    podsIndex = @
    xhr = new XMLHttpRequest()
    xhr.open('GET', @seedsURL+'/pods.mpac', true)
    xhr.responseType = 'arraybuffer'
    xhr.onload = (e) ->
      podsIndex.index = msgpack.decode(@response)
      callback(podsIndex)
    xhr.send()
