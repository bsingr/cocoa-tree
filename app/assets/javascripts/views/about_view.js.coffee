@AboutView = Backbone.View.extend
  template: JST['templates/about']
  el: '#main-view'
  render: () ->
    html = @template()
    @$el.html(html)
    @