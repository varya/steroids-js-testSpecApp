describe "modal", ->

  it "should be defined", ->
    expect( steroids.modal ).toBeDefined()

  describe "show", ->

    it "should be defined", ->
      expect( steroids.modal.show ).toBeDefined()

    it "should present and hide a modal", ->

      presented = false
      dismissed = false

      waits(500)

      runs ->
        googleView = new steroids.views.WebView("http://www.google.com")

        steroids.modal.show { view: googleView },
          onSuccess: -> presented = true

      waitsFor (-> presented), "should be presented", 2500

      runs ->
        expect(presented).toBeTruthy()

      waits(2000)

      runs ->
        steroids.modal.hide {},
          onSuccess: -> dismissed = true
          onFailure: (msg) ->
            # KLUDGE: the Jasmine.js afterEach function wouldn't execute after this test fails for some reason, so must call modal.hide manually.
            steroids.logger.log(JSON.stringify(msg))
            steroids.modal.hide()

      waitsFor (-> dismissed), "should be dismissed", 2500

      runs ->

        expect( dismissed ).toBeTruthy()

  describe "hideAll", ->

    it "should be defined", ->
      expect( steroids.modal.hideAll ).toBeDefined()

    it "should present and hide a modal", ->

      presented = false
      dismissed = false

      waits(500)

      runs ->
        googleView = new steroids.views.WebView("http://www.google.com")

        steroids.modal.show { view: googleView },
          onSuccess: -> presented = true

      waitsFor (-> presented), "should be presented", 2500

      runs ->
        expect(presented).toBeTruthy()

      waits(2000)

      runs ->
        steroids.modal.hideAll {},
          onSuccess: -> dismissed = true
          onFailure: (msg) ->
            # KLUDGE: the Jasmine.js afterEach function wouldn't execute after this test fails for some reason, so must call modal.hide manually.
            steroids.logger.log(JSON.stringify(msg))
            steroids.modal.hide()

      waitsFor (-> dismissed), "should be dismissed", 2500

      runs ->
        expect( dismissed ).toBeTruthy()
