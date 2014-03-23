describe "parser/models/parser_option_model", ->
  SpecHelpers.load_modules(
    "parser/models/parser_option_model"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  context "get_value()について", ->
    context "typeがtextで適当なvalueを持つとき", ->
      beforeEach ->
        @data.option = new @modules.ParserOptionModel
          type: "text"
          value: "this is option value"

      context "get_value()を実行すると", ->
        beforeEach ->
          @data.ret = @data.option.get_value()

        it "should return this is option value", ->
          expect(@data.ret).to.eql "this is option value"

    context "typeがtextでStringでないvalueを持つとき", ->
      context "valueが整数のとき", ->
        beforeEach ->
          @data.option = new @modules.ParserOptionModel
            type: "text"
            value: 12345

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return 12345", ->
            expect(@data.ret).to.eql "12345"

      context "toString()を持つオブジェクトのとき", ->
        beforeEach ->
          @data.option = new @modules.ParserOptionModel
            type: "text"
            value:
              toString: ->
                "this is dummy"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return 'this is dummy'", ->
            expect(@data.ret).to.eql "this is dummy"

  context "set_value()について", ->
    context "typeがtextのとき", ->
      beforeEach ->
        @data.option = new @modules.ParserOptionModel
          type: "text"

      context "set_value(aaa)を実行して", ->
        beforeEach ->
          @data.option.set_value "aaa"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return aaa", ->
            expect(@data.ret).to.eql "aaa"

      context "set_value(test test test)を実行して", ->
        beforeEach ->
          @data.option.set_value "test test test"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return test test test", ->
            expect(@data.ret).to.eql "test test test"

      context "set_valueに整数12345を渡して", ->
        beforeEach ->
          @data.option.set_value 12345

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return 12345", ->
            expect(@data.ret).to.eql "12345"

      context "set_valueにtoStringを持つオブジェクトを渡して", ->
        beforeEach ->
          @data.option.set_value
            toString: ->
              "this is toString"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return this is toString", ->
            expect(@data.ret).to.eql "this is toString"

