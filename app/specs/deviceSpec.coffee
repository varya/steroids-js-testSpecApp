describe "device", ->

  describe "torch", ->

    describe "toggle", ->
      _toggled = false

      beforeAll ->
        steroids.device.torch.toggle {},
          onSuccess: -> _toggled = true

        waitsFor -> _toggled

      it "succeeds", ->
        expect( _toggled ).toBeTruthy()

    describe "turnOn", ->
      _turnedOn = false

      beforeAll ->
        steroids.device.torch.turnOn {},
          onSuccess: -> _turnedOn = true

        waitsFor -> _turnedOn

      it "succeeds", ->
        expect( _turnedOn ).toBeTruthy()

    describe "turnOff", ->
      _turnedOff = false

      beforeAll ->
        steroids.device.torch.turnOff {},
          onSuccess: -> _turnedOff = true

        waitsFor -> _turnedOff

      it "succeeds", ->
        expect( _turnedOff ).toBeTruthy()

  describe "ping", ->

    describe "when called", ->
      _ponged = false

      beforeAll ->
        steroids.device.ping {},
          onSuccess: -> _ponged = true

        waitsFor -> _ponged

      it "pongs", ->
        expect( _ponged ).toBeTruthy()

  describe "getIPAddress", ->
    _ip = null

    steroids.device.getIPAddress {},
      onSuccess: (message) -> _ip = message.ipAddress

    waitsFor -> _ip?

    it "to get a sensible value", ->
      expect( _ip ).toMatch(/192\.168\..*/)

  describe "sleep mode", ->

    describe "enableSleep", ->
      _called = false
      steroids.device.enableSleep {},
        onSuccess: -> _called = true

      waitsFor -> _called

      it "succeeds", ->
        expect(_called).toBeTruthy()

    describe "disableSleep", ->
      _called = false
      steroids.device.disableSleep {},
        onSuccess: -> _called = true

      waitsFor -> _called

      it "succeeds", ->
        expect(_called).toBeTruthy()

  describe "platform", ->

    describe "getName", ->
      _name = null

      beforeAll ->
        steroids.device.platform.getName {},
          onSuccess: (gotName) -> _name = gotName

        waitsFor -> _name?

      it "is given a correct name", ->
        if navigator.userAgent.match(/(iPod|iPhone|iPad)/)
          expect( _name ).toBe("ios")
        else
          expect( "you" ).toBe("fixing this test for that device you are using")

