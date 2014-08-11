describe "view", ->

  it "should be defined", ->
    expect(steroids.view).toBeDefined()

  it "should track WebView events", ->

    created = false
    preloaded = false
    unloaded = false
    testView = undefined

    steroids.view.on "created", ->
      created = true

    steroids.view.on "preloaded", ->
      preloaded = true

    steroids.view.on "unloaded", ->
      unloaded = true

    runs ->

      testView = new steroids.views.WebView {location: "http://www.google.com", id:"eventTrackerTest"}
      expect(created).toBeTruthy

    runs ->
      testView.preload()

    waitsFor (-> preloaded), "view should be preloaded", 5000

    runs ->
      expect(preloaded).toBeTruthy()

    runs ->
      testView.unload()

    waitsFor (->unloaded), "view should be unloaded", 5000

    runs ->
      expect(unloaded).toBeTruthy()
