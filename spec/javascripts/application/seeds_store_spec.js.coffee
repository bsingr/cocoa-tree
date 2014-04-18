describe 'PodsList', ->
  subject = null
  beforeEach (done) ->
    subject = new SeedsStore('test')
    expect(subject.clear()).eventually.notify(done)
  it 'counts 0', (done) ->
    expect(subject.countForAll()).eventually.equal(0).notify(done)
  it 'counts n', (done) ->
    subject.update([{name: 1},{name: 2},{name: 3}])
    expect(subject.countForAll()).eventually.equal(3).notify(done)
  it 'readPod', (done) ->
    subject.update([{name: 1}, {name: 2}])
    expect(subject.readPod(1)).eventually.eql([{name: 1}]).notify(done)
  describe 'readsFromAll', ->
    listByName = [
      {name: 1, category: 10},
      {name: 2, category: 20},
      {name: 3, category: 15},
      {name: 4, category: 20}
    ]
    listByCategory = [
      listByName[0],
      listByName[2],
      listByName[1],
      listByName[3]
    ]
    beforeEach (done) ->
      expect(subject.update(listByName))
        .eventually.notify(done)
    describe 'name', ->
      list = listByName
      sortBy = 'name'
      describe 'asc', ->
        sortOrderAsc = true
        it 'from the beginning', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 0, 1)).eventually
            .eql([list[0]]).notify(done)
        it 'in the middle', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 1, 2)).eventually
            .eql([list[1], list[2]]).notify(done)
        it 'beyond scope', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 3, 2)).eventually
            .eql([list[3]]).notify(done)
      describe 'desc', ->
        sortOrderAsc = false
        it 'from the beginning', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 0, 1)).eventually
            .eql([list[3]]).notify(done)
        it 'in the middle', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 1, 2)).eventually
            .eql([list[2], list[1]]).notify(done)
        it 'beyond scope', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 3, 2)).eventually
            .eql([list[0]]).notify(done)
    describe 'category', ->
      list = listByCategory
      sortBy = 'category'
      describe 'asc', ->
        sortOrderAsc = true
        it 'from the beginning', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 0, 1)).eventually
            .eql([list[0]]).notify(done)
        it 'in the middle', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 1, 2)).eventually
            .eql([list[1], list[2]]).notify(done)
        it 'beyond scope', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 3, 2)).eventually
            .eql([list[3]]).notify(done)
      describe 'desc', ->
        sortOrderAsc = false
        it 'from the beginning', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 0, 1)).eventually
            .eql([list[3]]).notify(done)
        it 'in the middle', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 1, 2)).eventually
            .eql([list[2], list[1]]).notify(done)
        it 'beyond scope', (done) ->
          expect(subject.readFromAll(sortBy, sortOrderAsc, 3, 2)).eventually
            .eql([list[0]]).notify(done)