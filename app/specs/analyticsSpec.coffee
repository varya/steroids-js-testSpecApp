describe "analytics", ->

  describe "track", ->

    describe "when called", ->
      _analyticEventTracked = false

      beforeAll ->
        steroids.analytics.track {},
          onSuccess: -> _analyticEventTracked = true
        waitsFor -> _analyticEventTracked

      it "tracks the event", ->
        expect(_analyticEventTracked).toBeTruthy()