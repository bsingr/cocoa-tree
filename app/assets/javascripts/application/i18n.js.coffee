class @I18n
  category: (name) ->
    if @categories[name]
      @categories[name]
    else
      name
  categories:
    "proprietary_api": "Proprietary API"
    "functional_programming": "Functional Programming"
    "gui": "Graphical User Interface"
