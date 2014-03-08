describe 'PodsSorter', ->
  subject = null
  beforeEach ->
     subject = new PodsSorter
  describe '#sort()', ->
    it 'empty input', ->
      expect(subject.sort([])).to.eql([])
    it 'without sort_by', ->
      expect(subject.sort([1,3,2])).to.eql([3,2,1])
    it 'sorts by integer property', ->
      list = [
        {i: 1}
        {i: 3}
        {i: 2}
      ]
      sorted_list = [
        {i: 3}
        {i: 2}
        {i: 1}
      ]
      subject.sort_by = 'i'
      expect(subject.sort(list)).to.eql(sorted_list)
    it 'sorts by mixed property', ->
      list = [
        {i: null}
        {i: 'not a number'}
        {i: 2}
        {i: null}
        {i: 1}
        {i: 'not a number'}
      ]
      sorted_list = [
        {i: 2}
        {i: 1}
        {i: 'not a number'}
        {i: 'not a number'}
        {i: null}
        {i: null} 
      ]
      subject.sort_by = 'i'
      expect(subject.sort(list)).to.eql(sorted_list)
    it 'sorts by string property', ->
      list = [
        {i: 'A'}
        {i: 'C'}
        {i: 'b'}
      ]
      sorted_list = [
        {i: 'A'}
        {i: 'b'}
        {i: 'C'}
      ]
      subject.sort_by = 'i'
      expect(subject.sort(list)).to.eql(sorted_list)

