define (require) ->
  msgpack = require 'msgpack-js'
  class PodsIndex
    load: (callback) ->
      xhr = new XMLHttpRequest()
      xhr.open('GET', '/pods.mpac', true)
      xhr.responseType = 'arraybuffer'
      xhr.onload = (e) ->
        index = msgpack.decode(@response)
        callback(index)
      xhr.send()
