class @PodsFilterRenderer
  categories: [
    "xml"
    "json"
    "api"
    "http"
    "string"
    "md5"
    "sha1"
    "hmac"
    "url"
    "ui"
    "network"
    "ipad"
    "ios"
    "iphone"
    "mac"
    "osx"
    "image"
    "view"
    "calendar"
    "csv"
    "navigation"
  ]
  render: (pods) ->
    podsWordStats = new PodsWordStats()
    podsWordStats.generate(pods)
    html = JST['templates/pods_categories']
      categories: @categories
      word_stats: podsWordStats.wordStats
    $(".categories").html html
  