describe 'SeedsStore', ->
  beforeEach (done) ->
    @subject = new SeedsStore('test')
    expect(@subject.clear()).eventually.notify(done)
  it 'counts 0', (done) ->
    expect(@subject.countForAll()).eventually.equal(0).notify(done)
  it 'counts n', (done) ->
    @subject.update([{name: 1},{name: 2},{name: 3}])
    expect(@subject.countForAll()).eventually.equal(3).notify(done)
  it 'readPod', (done) ->
    @subject.update([{name: 1}, {name: 2}])
    expect(@subject.readPod(1)).eventually.eql([{name: 1}]).notify(done)
  describe 'large dataset', ->
    beforeEach () ->        
      @listByName = ->
        [
          {name: 1, category: 'a', stars: 1},
          {name: 2, category: 'c', stars: 5},
          {name: 3, category: 'b', stars: 4},
          {name: 4, category: 'c', stars: 6},
          {name: 5, category: 'c', stars: 3},
          {name: 6, category: 'c', stars: 2}
        ]
      @listByCategory = ->
        list = @listByName()
        [
          list[0],
          list[2],
          list[1],
          list[3],
          list[4],
          list[5]
        ]
      @listByStars = ->
        list = @listByName()
        [
          list[0],
          list[5],
          list[4],
          list[2],
          list[1],
          list[3]
        ]
      @listForCategoryByName = ->
        list = @listByName()
        [
          list[1],
          list[3],
          list[4],
          list[5]
        ]
      @listForCategoryByStars = ->
        list = @listByName()
        [
          list[5],
          list[4],
          list[1],
          list[3]
        ]
    beforeEach (done) ->
      expect(@subject.update(@listByName()))
        .eventually.notify(done)
    beforeEach (done) ->
      expect(@subject.updateCategories())
        .eventually.notify(done)
    it 'updateCategories() + categories()', (done) ->
      expect(@subject.categories()).eventually
        .eql([
          {name: 'a', podsCount: 1},
          {name: 'b', podsCount: 1},
          {name: 'c', podsCount: 4}
        ]).notify(done)
    expectReadAll = () ->
      describe 'readFromAll()', ->
        it 'from the beginning', (done) ->
          expect(@subject.readFromAll(@sortBy, @sortOrderAsc, 0, 1)).eventually
            .eql([@list[0]]).notify(done)
        it 'in the middle', (done) ->
          expect(@subject.readFromAll(@sortBy, @sortOrderAsc, 1, 2)).eventually
            .eql([@list[1], @list[2]]).notify(done)
        it 'beyond scope', (done) ->
          expect(@subject.readFromAll(@sortBy, @sortOrderAsc, 5, 2)).eventually
            .eql([@list[5]]).notify(done)
    expectReadCategory = () ->
      describe 'readFromCategory()', ->
        it 'from the beginning', (done) ->
          expect(@subject.readFromCategory(@category, @sortBy, @sortOrderAsc, 0, 1)).eventually
            .eql([@listForCategory[0]]).notify(done)
        it 'in the middle', (done) ->
          expect(@subject.readFromCategory(@category, @sortBy, @sortOrderAsc, 1, 2)).eventually
            .eql([@listForCategory[1], @listForCategory[2]]).notify(done)
        it 'beyond scope', (done) ->
          expect(@subject.readFromCategory(@category, @sortBy, @sortOrderAsc, 3, 2)).eventually
            .eql([@listForCategory[3]]).notify(done)
    describe 'sortBy=name', ->
      beforeEach () ->
        @sortBy = 'name'
      describe 'order=asc', ->
        beforeEach () ->
          @list = @listByName()
          @listForCategory = @listForCategoryByName()
          @sortOrderAsc = true
          @category = 'c'
        expectReadAll()
        expectReadCategory()
      describe 'order=desc', ->
        beforeEach () ->
          @list = @listByName().reverse()
          @listForCategory = @listForCategoryByName().reverse()
          @sortOrderAsc = false
          @category = 'c'
        expectReadAll()
        expectReadCategory()
    describe 'sortBy=stars', ->
      beforeEach () ->
        @sortBy = 'stars'
      describe 'order=asc', ->
        beforeEach () ->
          @list = @listByStars()
          @listForCategory = @listForCategoryByStars()
          @sortOrderAsc = true
          @category = 'c'
        expectReadAll()
        expectReadCategory()
      describe 'order=desc', ->
        beforeEach () ->
          @list = @listByStars().reverse()
          @listForCategory = @listForCategoryByStars().reverse()
          @sortOrderAsc = false
          @category = 'c'
        expectReadAll()
        expectReadCategory()
