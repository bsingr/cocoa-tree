@EmptyView = Backbone.View.extend
  template: JST['templates/empty']
  el: '#main-view'
  render: () ->
    @$el.html(@template())
    @
    