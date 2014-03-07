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
  constructor: (pods_controller) ->
    @pods_controller = pods_controller
    @pods_controller.delegates.push(@)
  render: (pods_word_stats) ->
    html = JST['templates/pods_categories']
      categories: @categories
      word_stats: pods_word_stats.wordStats
    $(".categories").html html
  podsDidChange: () ->
    pods_word_stats = new PodsWordStats()
    pods_word_stats.generate(@pods_controller.pods)
    @render(pods_word_stats)
  