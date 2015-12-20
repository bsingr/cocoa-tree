class @SeedsIndex
  constructor: (seedsURL) ->
    @seedsURL = seedsURL
  load: (callback) ->
    index = @
    xhr = new XMLHttpRequest()
    xhr.open('GET', @seedsURL + '.json', true)
    # xhr.responseType = 'arraybuffer'
    xhr.onload = (e) ->
      index.index = JSON.parse(@response)
      # index.index = msgpack.decode(@response)
      callback(index)
    xhr.send()
