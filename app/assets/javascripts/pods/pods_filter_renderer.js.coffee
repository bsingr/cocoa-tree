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
  render: ->
    categoriesHtml = []
    for categoryName in @categories
      categoriesHtml.push "<a href='#pods/" + categoryName + "/0'>" + categoryName + " </a>"
    $(".categories").html categoriesHtml.join(" ")
    