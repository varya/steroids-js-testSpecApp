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

      waitsFor (-> presented), "should be presented", 5000

      runs ->
        expect(presented).toBeTruthy()

      waits(1500)

      runs ->
        steroids.modal.hide {},
          onSuccess: -> dismissed = true
          onFailure: (msg) -> alert(JSON.stringify(msg))

        waitsFor (-> dismissed), "should be dismissed", 5000

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

      waitsFor (-> presented), "should be presented", 5000

      runs ->
        expect(presented).toBeTruthy()

      waits(1500)

      runs ->
        steroids.modal.hideAll {},
          onSuccess: -> dismissed = true
          onFailure: (msg) -> alert(JSON.stringify(msg))

        waitsFor (-> dismissed), "should be dismissed", 5000

        runs ->
          expect( dismissed ).toBeTruthy()
