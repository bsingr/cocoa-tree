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