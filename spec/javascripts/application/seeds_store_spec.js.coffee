describe 'PodsList', ->
  it 'is empty', ->
    subject = new SeedsStore('test')
    expect(subject.countForAll()).to.eventually.eql(0)
