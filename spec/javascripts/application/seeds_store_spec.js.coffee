describe 'SeedsStore', ->
  beforeEach (done) ->
    @subject = new SeedsStore('test')
    expect(@subject.clear()).eventually.notify(done)
  describe 'counts', ->
  it 'counts 0', (done) ->
    expect(@subject.countForAll()).eventually.equal(0).notify(done)
  describe 'large dataset', ->
    beforeEach () ->
      @listByName = ->
        [
          {name: 'a', category: 'a', stars: 1},
          {name: 'b', category: 'c', stars: 5},
          {name: 'c', category: 'b', stars: 4},
          {name: 'd', category: 'c', stars: 6},
          {name: 'e', category: 'c', stars: 3},
          {name: 'f', category: 'c', stars: 2}
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
      @normalizePods = (docs) ->
        normalized = []
        for doc in docs
          normalized.push
            name: doc.name
            category: doc.category
            stars: doc.stars
        normalized
    beforeEach (done) ->
      expect(@subject.update(@listByName()))
        .eventually.notify(done)
    it 'counts n', (done) ->
      expect(@subject.countForAll()).eventually.equal(6).notify(done)
    it 'readPod', (done) ->
      p = @subject.readPod('c').then(@normalizePods)
      expect(p).eventually
        .eql([@listByName()[2]]).notify(done)
    describe 'updateCategories()', ->    
      beforeEach (done) ->
        expect(@subject.updateCategories())
          .eventually.notify(done)
      it 'categories()', (done) ->
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
