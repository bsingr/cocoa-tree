window.load_categories = ->
  categories =
    xml: []
    json: []
    api: []
    http: []
    string: []
    md5: []
    sha1: []
    hmac: []
    url: []
    ui: []
    network: []
    ipad: []
    ios: []
    iphone: []
    mac: []
    osx: []
    image: []
    view: []
    calendar: []
    csv: []
    navigation: []
  categoryForName = (name) ->
    for categoryName of categories
      return categories[categoryName] if name.match(categoryName)
    false

  wordStats = {}
  wordList = []
  $(".pod .summary").each ->
    element = $(this).parents(".pod").first().get(0)
    words = $(this).text().replace(/\.$/, "").split(" ")
    i = 0
    while i < words.length
      word = words[i].toLowerCase()
      i++
      if word.length > 2
        category = categoryForName(word)
        category.push wordStats[word] if category
        if wordStats[word] is `undefined`
          wordStats[word] =
            word: word
            count: 0
            elements: []
          wordList.push wordStats[word]
        wordStats[word].count += 1
        wordStats[word].elements.push element
  
  sortedWordList = wordList.sort((a, b) ->
    b.count - a.count
  )
  html = []
  i = 0
  while i < 100
    stats = sortedWordList[i]
    i++
    html.push "<a href='#!/filter/" + stats.word + "'>" + stats.word + "</a>"  if stats
  $(".tags").html html.join(" ")
