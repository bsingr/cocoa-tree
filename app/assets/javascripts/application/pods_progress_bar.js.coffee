#= require nanobar.js
class @PodsProgressBar
  update: (factor) ->
    progress = factor * 100
    if @nanobar
      @nanobar.go(progress)
  start: ->
    $container = $('.progress-container').empty()
    @nanobar = new Nanobar
      target: $container.get(0)
      id: 'pods-progress'
  