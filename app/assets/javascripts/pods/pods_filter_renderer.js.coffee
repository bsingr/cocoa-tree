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
  constructor: (pods_controller, podsStore) ->
    @pods_controller = pods_controller
    @pods_controller.delegates.push(@)
    @podsStore = podsStore
  render: (pods_word_stats) ->
    html = JST['templates/pods_categories']
      categories: @categories
      word_stats: pods_word_stats.wordStats
    $(".categories").html html
  podsDidChange: () ->
    pods_word_stats = new PodsWordStats()
    pods_word_stats.generate(@podsStore.all())
    @render(pods_word_stats)
  