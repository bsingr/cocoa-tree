class @Logger
  levels:
    error: 0
    warn: 1
    info: 2
    verbose: 3
  constructor: (console, env) ->
    @env = env
    @console = console
  error: (statements...) ->
    @log('error', statements...)
  warn: (statements...) ->
    @log('warn', statements...)
  info: (statements...) ->
    @log('info', statements...)
  verbose: (statements...) ->
    @log('verbose', statements...)
  log: (level, statements...) ->
    if @levels[level] <= @levels[LOG_LEVEL]
      if @console && @console.log
        s = [new Date(), @env].concat(statements)
        @console.log s.join(' ')

LOG_LEVEL = 'info'