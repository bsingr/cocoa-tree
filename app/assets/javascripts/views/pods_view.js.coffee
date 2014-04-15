#= require jquery.timeago.js
@PodsView = Backbone.View.extend
  template: JST['templates/pods']
  el: '#main-view'
  render: (podsList) ->
    html = @template
      podsList: podsList
      i18n: new I18n()
    @$el.append(html)
    @$el.find(".timeago").timeago()
    @
