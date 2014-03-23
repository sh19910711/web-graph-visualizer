describe "parser/models/parser_option_model", ->
  SpecHelpers.load_modules(
    "parser/models/parser_option_model"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  context "typeがselectのときについて", ->
    context "何もオプションを持たないとき", ->
      beforeEach ->
        @data.option = new @modules.ParserOptionModel
          type: "select"
          options: []

      context "何も操作せずに", ->
        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should not exist", ->
            expect(@data.ret).to.not.exist

      context "存在しないオプションを選択すると", ->
        beforeEach ->
          @data.func = =>
            @data.option.set_value "option 1"

        it "should throw Error", ->
          expect(@data.func).to.throw Error

    context "1つのオプションを持つとき", ->
      beforeEach ->
        @data.option = new @modules.ParserOptionModel
          type: "select"
          options: [
            "option 1"
          ]

      context "何もせずに", ->
        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return option 1", ->
            expect(@data.ret).to.eql "option 1"

      context "option 1を選択して", ->
        beforeEach ->
          @data.option.set_value "option 1"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return option 1", ->
            expect(@data.ret).to.eql "option 1"

      context "存在しないオプションを選択すると", ->
        beforeEach ->
          @data.func = =>
            @data.set_value "option 2"

        it "should throw Error", ->
          expect(@data.func).to.throw Error

    context "3つのオプションを持つとき", ->
      beforeEach ->
        @data.option = new @modules.ParserOptionModel
          type: "select"
          options: [
            "option 1"
            "option 2"
            "option 3"
          ]

      context "何もせずに", ->
        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return option 1", ->
            expect(@data.ret).to.eql "option 1"

      context "option 1を選択して", ->
        beforeEach ->
          @data.option.set_value "option 1"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return option 1", ->
            expect(@data.ret).to.eql "option 1"

      context "option 2を選択して", ->
        beforeEach ->
          @data.option.set_value "option 2"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return option 2", ->
            expect(@data.ret).to.eql "option 2"

      context "option 3を選択して", ->
        beforeEach ->
          @data.option.set_value "option 3"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return option 3", ->
            expect(@data.ret).to.eql "option 3"

      context "存在しないオプションoption 4を選択すると", ->
        beforeEach ->
          @data.func = =>
            @data.option.set_value "option 4"

        it "should throw Error", ->
          expect(@data.func).to.throw Error

  context "typeがtextのときについて", ->
    context "get_value()について", ->
      context "適当なvalueを持つとき", ->
        beforeEach ->
          @data.option = new @modules.ParserOptionModel
            type: "text"
            value: "this is option value"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should return this is option value", ->
            expect(@data.ret).to.eql "this is option value"

      context "Stringでないvalueを持つとき", ->
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
      context "値が設定されていないときに", ->
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

