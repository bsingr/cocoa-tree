class @PodsWordStats
  wordStats: {}
  wordList: []
  generate: (pods) ->
    @wordStats = {}
    @wordList = []
    for pod in pods
      words = pod.summary.toLowerCase().split(" ")
      i = 0
      while i < words.length
        word = words[i].toLowerCase()
        i++
        if word.length > 1
          if @wordStats[word] is `undefined`
            @wordStats[word] = 0
          @wordStats[word] += 1
    for word, count of @wordStats
      @wordList.push
        word: word
        count: count
    @wordList = @wordList.sort((a, b) ->
      b.count - a.count
    )