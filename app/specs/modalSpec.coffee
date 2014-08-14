describe "modal", ->

  defaultCallbacks =
    onSuccess: () ->
    onFailure: (error) ->
      alert "Test fail: " + error.errorDescription

  # Set up listeners for show transition events ending
  isShown = false
  isClosed= false

  steroids.modal.on "didshow", () ->
    isShown = true

  steroids.modal.on "didclose", () ->
    isClosed = true

  beforeEach () ->
    isShown = false
    isClosed = false

  it "should be defined", ->
    expect( steroids.modal ).toBeDefined()

  describe "show", ->

    it "should be defined", ->
      expect( steroids.modal.show ).toBeDefined()

    it "should present and hide a modal", ->

      waits(500)

      runs ->
        googleView = new steroids.views.WebView "http://www.google.com"

        steroids.modal.show googleView

      waitsFor (-> isShown), "should be presented", 5000

      runs ->
        expect(isShown).toBeTruthy()

      runs ->
        steroids.modal.hide {}, defaultCallbacks

        waitsFor (-> isClosed), "should be dismissed", 5000

        runs ->

          expect(isClosed).toBeTruthy()

  describe "hideAll", ->

    it "should be defined", ->
      expect( steroids.modal.hideAll ).toBeDefined()

    it "should present and hide a modal", ->

      waits(500)

      runs ->
        googleView = new steroids.views.WebView "http://www.google.com"

        steroids.modal.show googleView

      waitsFor (-> isShown), "should be presented", 5000

      runs ->
        expect(isShown).toBeTruthy()

      runs ->
        steroids.modal.hideAll {}, defaultCallbacks

        waitsFor (-> isClosed), "should be dismissed", 5000

        runs ->
          expect(isClosed).toBeTruthy()
