class @Logger
  verbose: (statements...) ->
    @log('verbose', statements...)
  log: (level, statements...) ->
    if console && console.log
      console.log new Date(), statements...
@logger = new Logger()
