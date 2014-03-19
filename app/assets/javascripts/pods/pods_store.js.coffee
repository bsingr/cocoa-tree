class @PodsStore
  records: []
  all: ->
    @records
  update: (new_records) ->
    @records = @records.concat(new_records)
