@ContributeView = Backbone.View.extend
  template: JST['templates/contribute']
  el: '#main-view'
  render: () ->
    html = @template()
    @$el.html(html)
    @