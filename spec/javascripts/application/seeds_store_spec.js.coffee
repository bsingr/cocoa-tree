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
    beforeEach (done) ->
      list = [{name: 1}, {name: 2}, {name: 3}, {name: 4}]
      expect(subject.update(list))
        .eventually.notify(done)
    it 'readsFromAll name,asc from the beginning', (done) ->
      expect(subject.readFromAll('name', true, 0, 1)).eventually
        .eql([{name: 1}]).notify(done)
    it 'readsFromAll name,asc in the middle', (done) ->
      expect(subject.readFromAll('name', true, 1, 2)).eventually
        .eql([{name: 2}, {name: 3}]).notify(done)
    it 'readsFromAll name,asc out of scope', (done) ->
      expect(subject.readFromAll('name', true, 3, 2)).eventually
        .eql([{name: 4}]).notify(done)
        