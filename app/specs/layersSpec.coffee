describe "layers", ->

  it "should be defined", ->
    expect( steroids.layers ).toBeDefined()

  describe "push and pop", ->

    it "should push and pop a view", ->

      pushed = false
      popped = false

      waits(2000)

      runs ->
        googleView = new steroids.views.WebView "http://www.google.com"

        steroids.layers.push googleView,
          onSuccess: ->
            pushed = true
          onFailure: (error) ->
            alert JSON.stringify error

      waitsFor (-> pushed), "Layer should be pushed", 5000

      runs ->
        expect( pushed ).toBeTruthy()

      waits(2000)

      runs ->
        steroids.layers.pop {},
          onSuccess: ->
            popped = true
          onFailure: (error) ->
            alert JSON.stringify error


      waitsFor (-> popped), "Layer should be popped", 5000

      waits(2000)

      runs ->
        expect( popped ).toBeTruthy()

  describe "layers.on", ->
    it "should log 4 layer events", ->

      eventsCount = 0

      steroids.layers.on "willchange", ->
        eventsCount++

      steroids.layers.on "didchange", ->
        eventsCount++

      pushed = false
      popped = false

      waits(2000)

      runs ->
        googleView = new steroids.views.WebView "http://www.google.com"

        steroids.layers.push googleView,
          onSuccess: ->
            pushed = true
          onFailure: (error) ->
            alert JSON.stringify error

      waitsFor (-> pushed), "Layer should be pushed", 5000
      waits(2000)

      runs ->
        steroids.layers.pop {},
          onSuccess: ->
            popped = true


      waitsFor (-> popped), "Layer should be popped", 5000
      waits(2000)

      runs ->
        expect( eventsCount ).toEqual(4)

describe "visibilitychange", ->

    it "should log two visibilitychange events", ->
      visibilityChangeCount = 0
      hidden = false
      visible = false

      document.addEventListener "visibilitychange", ->
        visibilityChangeCount += 1
        if document.visibilityState is "hidden"
          hidden = true
        if document.visibilityState is "visible"
          visible = true

      pushed = false
      popped = false
      animationFinished = false

      googleView = new steroids.views.WebView "http://www.google.com"

      steroids.layers.push googleView,
        onSuccess: ->
          pushed = true

      waitsFor -> pushed

      runs ->
        expect( pushed ).toBeTruthy()

      window.setTimeout =>
        steroids.layers.pop {},
          onSuccess: ->
            popped = true
      , 2000

      waitsFor -> popped

      runs ->
        window.setTimeout =>
          animationFinished = true
        , 2000

        waitsFor -> animationFinished

        runs ->
          expect(visibilityChangeCount).toEqual(2)
          expect(hidden).toBeTruthy()
          expect(visible).toBeTruthy()



