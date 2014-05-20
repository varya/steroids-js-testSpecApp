describe "animation", ->

  describe "perform", ->
    _started = false
    _succeeded = false
    _ended = false
    _failed = false

    beforeAll ->
      animation = new steroids.Animation()
      animation.perform {},
        onSuccess: -> _succeeded = true
        onAnimationStarted: -> _started = true
        onAnimationEnded: -> _ended = true

      waitsFor -> _succeeded and _ended and _started and not _failed

    it "starts", ->
      expect( _started ).toBeTruthy()

    it "succeeds", ->
      expect( _succeeded ).toBeTruthy()

    it "ends", ->
      expect( _ended ).toBeTruthy()
