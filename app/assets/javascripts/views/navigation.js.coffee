@Navigation = Backbone.View.extend
  template: JST['templates/navigation']
  el: '.navbar-container'
  render: ->
    @$el.html(@template())
