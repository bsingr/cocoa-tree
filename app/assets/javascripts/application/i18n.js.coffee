class @I18n
  category: (name) ->
    humanized = S(name).humanize().s
    for part in @uppercase
      humanized = humanized.replace(new RegExp(part, 'gi'), part.toUpperCase())
    humanized
  uppercase: [
    'api'
    'gui'
    'i18n'
    'json'
    'xml'
    'http'
    'https'
    'ftp'
    'ftps'
  ]
