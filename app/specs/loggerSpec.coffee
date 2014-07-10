describe "logger", ->

  describe "messages", ->

    it "should be initialized as an Array", ->
      expect( steroids.logger.messages.constructor.name ).toBe("Array")


  describe "log", ->

    describe "when called once", ->

      beforeAll ->
        # KLUDGE: logger.log is used to communicate in other test suites, so message buffer needs to be deleted before running test
        steroids.logger.messages=[]
        steroids.logger.log "hello"

      it "should have logged message in messages", ->
        expect( steroids.logger.messages.length ).toBe(1)


  describe "message", ->

    _message = null

    beforeAll ->
      steroids.logger.messages = []

      steroids.logger.log "hello world"
      _message = steroids.logger.messages.pop()

    it "should have right content", ->
      expect( _message.message ).toBe("hello world")

    it "should have location from window location", ->
      expect( _message.location ).toMatch(/\/views\/(logger|all)\/index\.html/)

    it "should have date", ->
      logDate = new Date()

      # LOL: unix epoch neckbeards vs hipster mustaches.

      expect( _message.date.getDate() ).toBe(logDate.getDate())
      expect( _message.date.getMonth() ).toBe(logDate.getMonth())
      expect( _message.date.getYear() ).toBe(logDate.getYear())

      expect( _message.date.getHours() ).toBe(logDate.getHours())
      expect( _message.date.getMinutes() ).toBe(logDate.getMinutes())
      expect( _message.date.getSeconds() ).toBe(logDate.getSeconds())


    it "should have a JSON presentation", ->

      messageAsJSON = _message.asJSON()
      expect( messageAsJSON.date ).toMatch(/\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d+Z/)

    it "should handle circular objects", ->
      circularObj =
        a: 'b'
      circularObj.circularRef = circularObj
      circularObj.list = [ circularObj, circularObj ]

      steroids.logger.log(circularObj)
      circularLogMessage = steroids.logger.messages.pop()
      circularMessageAsJSON = circularLogMessage.asJSON()

      expect( circularMessageAsJSON.message ).toBe('TypeError: JSON.stringify cannot serialize cyclic structures.')


  describe "queue", ->

    describe "when in scanner", ->

      it "should add the message to the queue", ->
        beforeQueueingLength = steroids.logger.queue.getLength()

        steroids.logger.log("to be queued")

        expect( steroids.logger.queue.getLength() ).toBe(beforeQueueingLength + 1)

    describe "when in standalone", ->

      beforeAll ->
        steroids.app.getMode = (options={}, callbacks={}) ->
          callbacks.onSuccess("standalone")

        steroids.logger.queue.messageQueue = []

        for msg in ["a","b","c"]
          steroids.logger.log(msg)

      it "should have not fill the queue", ->
        expect( steroids.logger.queue.getLength() ).toBe(0)


    describe "flush", ->

      describe "when in scanner", ->

        beforeAll ->
          steroids.app.getMode = (options={}, callbacks={}) ->
            callbacks.onSuccess("scanner")

          steroids.logger.queue.stopFlushing()

          for msg in ["a","b","c"]
            steroids.logger.log(msg)

        afterAll ->
          steroids.logger.queue.autoFlush(100)

        it "should have 3 messages before flush", ->
          expect( steroids.logger.queue.getLength() ).toBe(3)

        xit "should have 0 messages after flush", ->
          steroids.logger.queue.flush()

          waits(300)

          runs ->
            expect( steroids.logger.queue.getLength() ).toBe(0)


      describe "autoflushing", ->

        describe "when in scanner mode", ->

          beforeAll ->
            steroids.app.getMode = (options={}, callbacks={}) ->
              callbacks.onSuccess("scanner")

            for msg in ["a","b","c"]
              steroids.logger.log(msg)

          it "should flush automatically", ->
            waits(300)

            runs ->
              expect( steroids.logger.queue.getLength() ).toBe(0)

          it "should stop flushing", ->

            steroids.logger.queue.stopFlushing()

            for msg in ["a","b","c"]
              steroids.logger.log(msg)

            waits(300)

            runs ->
              expect( steroids.logger.queue.getLength() ).toBe(3)
