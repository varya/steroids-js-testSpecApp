describe "animation", ->

  describe "perform", ->
    describe "with valid transition", ->
      _started = false
      _succeeded = false
      _ended = false

      beforeAll ->
        animation = new steroids.Animation()
        animation.perform {},
          onSuccess: -> _succeeded = true
          onAnimationStarted: -> _started = true
          onAnimationEnded: -> _ended = true

        waitsFor -> _succeeded and _ended and _started

      it "starts", ->
        expect( _started ).toBeTruthy()

      it "succeeds", ->
        expect( _succeeded ).toBeTruthy()

      it "ends", ->
        expect( _ended ).toBeTruthy()

    describe "with invalid transition", ->
      _not_started = true
      _not_succeeded = true
      _not_ended = true
      _failed = false

      beforeAll ->
        animation = new steroids.Animation("invalid")
        animation.perform {},
          onSuccess: -> _not_succeeded = false
          onAnimationStarted: -> _started = false
          onAnimationEnded: -> _ended = false
          onFailure: -> _failed = true

        waitsFor -> _failed and _not_succeeded and _not_ended and _not_started

      it "fails", ->
        expect( _failed ).toBeTruthy()

      it "does not succeed", ->
        expect( _not_succeeded ).toBeTruthy()

