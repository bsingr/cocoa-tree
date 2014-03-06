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
    categoriesHtml = []
    for category_name in @categories
      categoriesHtml.push "<a href='#pods/" + category_name + "/0'>" + category_name + " " + pods_word_stats.wordStats[category_name] + " </a>"
    $(".categories").html categoriesHtml.join(" ")
  podsDidChange: () ->
    pods_word_stats = new PodsWordStats()
    pods_word_stats.generate(@pods_controller.pods)
    @render(pods_word_stats)
  