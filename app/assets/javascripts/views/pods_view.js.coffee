#= require jquery.timeago.js
@PodsView = Backbone.View.extend
  template: JST['templates/pods']
  el: '#main-view'
  render: (pods) ->
    html = @template
      pods: pods
    @$el.append(html)
    @$el.find(".timeago").timeago()
    @
