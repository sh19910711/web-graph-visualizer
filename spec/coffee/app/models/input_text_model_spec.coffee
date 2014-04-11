describe "app/models/input_text_model", ->
  SpecHelpers.load_modules(
    "app/models/input_text_model"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  beforeEach ->
    @server = sinon.fakeServer.create()

  afterEach ->
    @server.restore()

  context "get()について", ->
    context "text=this is textで生成して", ->
      beforeEach ->
        @data.input = new @modules.InputTextModel
          text: "this is test"

      context "textを取得すると", ->
        beforeEach ->
          @ret = @data.input.get "text"

        it "should equal this is test", ->
          expect(@ret).to.eql "this is test"

  context "fetch()について", ->
    context "GET /api/inputs/input_001を定義して", ->
      beforeEach ->
        @server.respondWith(
          "GET"
          "/api/inputs/input_001"
          [
            # Response Status
            200
            # Response Headers
            {
              "Content-Type": "application/json"
            }
            # Response Body
            JSON.stringify(
              text: "this is input_001"
            )
          ]
        )

      context "ID = input_001となるモデルを生成して", ->
        beforeEach ->
          @data.input = new @modules.InputTextModel
            id: "input_001"

        context "fetch()を実行してから", ->
          beforeEach (done)->
            deferred = @data.input.fetch()
            deferred.done ->
              console.log "done?"
              done()
            @server.respond()

          context "get()を実行すると", ->
            beforeEach ->
              @ret = @data.input.get "text"

            it "should equal this is input_001", ->
              expect(@ret).to.eql "this is input_001"


