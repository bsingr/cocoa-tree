class @I18n
  category: (name) ->
    if @categories[name]
      @categories[name]
    else
      Humanize.titleCase name
  categories:
    "core_data": "Core data"
    "debugging": "Debugging"
    "framework": "Framework"
    "functional_programming": "Functional programming"
    "gaming": "Gaming"
    "git": "Git"
    "gui": "Gui"
    "gui_controls": "Gui controls"
    "http": "Http"
    "image_processing": "Image processing"
    "json": "Json"
    "network": "Network"
    "proprietary_api": "Proprietary api"
    "reactive_programming": "Reactive programming"
    "sqlite": "Sqlite"
