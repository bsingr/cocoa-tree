describe 'PodsList', ->
  it 'is empty', ->
    subject = new PodsList(0, [], 0, 0)
    expect(subject.totalCount).to.eql(0)
    expect(subject.currentPods).to.eql([])
    expect(subject.index).to.eql(0)
    expect(subject.maxPerPage).to.eql(0)
  it 'contains 1', ->
    subject = new PodsList(1, [{}], 0, 0)
    expect(subject.totalCount).to.eql(1)
    expect(subject.currentPods).to.eql([{}])
    expect(subject.index).to.eql(0)
    expect(subject.maxPerPage).to.eql(0)
