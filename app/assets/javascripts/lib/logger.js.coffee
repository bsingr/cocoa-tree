class @Logger
  constructor: (console) ->
    @console = console
  verbose: (statements...) ->
    @log('verbose', statements...)
  log: (level, statements...) ->
    if @console && @console.log
      s = [new Date()].concat(statements)
      @console.log s.join(' ')
@logger = new Logger(console)
