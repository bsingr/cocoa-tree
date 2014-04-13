#= require jquery.timeago.js
@PodsView = Backbone.View.extend
  template: JST['templates/pods']
  el: '#main-view'
  render: (podsList) ->
    html = @template podsList
    @$el.append(html)
    @$el.find(".timeago").timeago()
    @
