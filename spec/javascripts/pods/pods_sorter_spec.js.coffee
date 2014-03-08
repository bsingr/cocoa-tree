describe 'PodsSorter', ->
  subject = null
  beforeEach ->
     subject = new PodsSorter
  describe '#sort()', ->
    it 'works without sort_by', ->
      expect(subject.sort([1,3,2])).to.eql([1,2,3])
    it 'sorts by property', ->
      list = [
        {i: 1}
        {i: 3}
        {i: 2}
      ]
      sorted_list = [
        {i: 1}
        {i: 2}
        {i: 3}
      ]
      subject.sort_by = 'i'
      expect(subject.sort(list)).to.eql(sorted_list)
    it 'works with empty input', ->
      expect(subject.sort([])).to.eql([])