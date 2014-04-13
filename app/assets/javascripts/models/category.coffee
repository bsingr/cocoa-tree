@Category = Backbone.Model.extend
  displayName: () ->
    i18n = new I18n()
    i18n.category(@get('name'))
