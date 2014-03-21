class @Logger
  constructor: (console, env) ->
    @env = env
    @console = console
  verbose: (statements...) ->
    @log('verbose', statements...)
  log: (level, statements...) ->
    if @console && @console.log
      s = [new Date(), @env].concat(statements)
      @console.log s.join(' ')
