describe "parser/models/parser_option_model", ->
  SpecHelpers.load_modules(
    "parser/models/parser_option_model"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  context "typeがhiddenのときについて", ->
    beforeEach ->
      @data.option = new @modules.ParserOptionModel
        type: "hidden"

    context "何もせずに", ->
      context "get_value()を実行すると", ->
        beforeEach ->
          @data.ret = @data.option.get_value()

        it "should not exist", ->
          expect(@data.ret).to.not.exist

    context "set_value(aiueo)を実行して", ->
      beforeEach ->
        @data.option.set_value "aiueo"

      context "get_value()を実行すると", ->
        beforeEach ->
          @data.ret = @data.option.get_value()

        it "should return aiueo", ->
          expect(@data.ret).to.eql "aiueo"

  context "typeがflagのときについて", ->
    context "nameが未指定のオプションを作成すると", ->
      beforeEach ->
        @data.func = =>
          @data.option = new @modules.ParserOptionModel
            type: "flag"

      it "should throw Error", ->
        expect(@data.func).to.throw Error

    context "nameがdummyのオプションを作成して", ->
      beforeEach ->
        @data.option = new @modules.ParserOptionModel
          type: "flag"
          name: "dummy"

      context "何も操作せずに", ->
        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should be false", ->
            expect(@data.ret).to.be.false

      context "set_value()を実行して", ->
        beforeEach ->
          @data.option.set_value()

        context "さらにset_value()を実行して", ->
          beforeEach ->
            @data.option.set_value()

          context "get_value()を実行すると", ->
            beforeEach ->
              @data.ret = @data.option.get_value()

            it "should be true", ->
              expect(@data.ret).to.be.false

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should be true", ->
            expect(@data.ret).to.be.true

      context "set_value(true)を実行して", ->
        beforeEach ->
          @data.option.set_value true

        context "さらにset_value()を実行して", ->
          beforeEach ->
            @data.option.set_value()

          context "get_value()を実行すると", ->
            beforeEach ->
              @data.ret = @data.option.get_value()

            it "should be true", ->
              expect(@data.ret).to.be.false

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should be true", ->
            expect(@data.ret).to.be.true

      context "set_value(false)を実行して", ->
        beforeEach ->
          @data.option.set_value false

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should be false", ->
            expect(@data.ret).to.be.false

  context "typeがmultiselectのときについて", ->
    context "何もオプションを持たないとき", ->
      beforeEach ->
        @data.option = new @modules.ParserOptionModel
          type: "multiselect"
          options: []

      context "何も操作せずに", ->
        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should exist", ->
            expect(@data.ret).to.exist

          it "should be empty", ->
            expect(@data.ret.length).to.eql 0

      context "存在しないオプションを選択すると", ->
        beforeEach ->
          @data.func = =>
            @data.ret = @data.option.set_value "option 1"

        it "should throw Error", ->
          expect(@data.func).to.throw Error

      context "オプションoption 1を追加して", ->
        beforeEach ->
          @data.option.add_option "option 1"

        context "何もせずに", ->
          context "get_value()を実行すると", ->
            beforeEach ->
              @data.ret = @data.option.get_value()

            it "should have no element", ->
              expect(@data.ret.length).to.eql 0

        context "オプションoption 2を追加して", ->
          beforeEach ->
            @data.option.add_option "option 2"

          context "何もせずに", ->
            context "get_value()を実行すると", ->
              beforeEach ->
                @data.ret = @data.option.get_value()

              it "should return empty array", ->
                expect(@data.ret.length).to.eql 0

          context "set_value(option 1)を実行して", ->
            beforeEach ->
              @data.option.set_value("option 1")

            context "get_value()を実行すると", ->
              beforeEach ->
                @data.ret = @data.option.get_value()

              it "should have one element", ->
                expect(@data.ret.length).to.eql 1

              it "should have option 1", ->
                expect(@data.ret).to.include "option 1"

          context "set_value(option 2)を実行して", ->
            beforeEach ->
              @data.option.set_value "option 2"

            context "get_value()を実行すると", ->
              beforeEach ->
                @data.ret = @data.option.get_value()

              it "should have one element", ->
                expect(@data.ret.length).to.eql 1

              it "should have option 2", ->
                expect(@data.ret).to.include "option 2"

            context "set_value(option 1)を実行して", ->
              beforeEach ->
                @data.option.set_value "option 1"

              context "get_value()を実行すると", ->
                beforeEach ->
                  @data.ret = @data.option.get_value()

                it "should have two elements", ->
                  expect(@data.ret.length).to.eql 2

                it "should have option 1", ->
                  expect(@data.ret).to.include "option 1"

                it "should have option 2", ->
                  expect(@data.ret).to.include "option 2"

              context "set_value(option 2)を実行して", ->
                beforeEach ->
                  @data.option.set_value "option 2"

                context "get_value()を実行すると", ->
                  beforeEach ->
                    @data.ret = @data.option.get_value()

                  it "should have one element", ->
                    expect(@data.ret.length).to.eql 1

                  it "should have option 1", ->
                    expect(@data.ret).to.include "option 1"

                context "set_value(option 1)を実行して", ->
                  beforeEach ->
                    @data.option.set_value "option 1"

                  context "get_value()を実行すると", ->
                    beforeEach ->
                      @data.ret = @data.option.get_value()

                    it "should have no element", ->
                      expect(@data.ret.length).to.eql 0

    context "1つのオプションを持つとき", ->
      beforeEach ->
        @data.option = new @modules.ParserOptionModel
          type: "multiselect"
          options: [
            "option 1"
          ]

      context "何も操作せずに", ->
        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should exist", ->
            expect(@data.ret).to.exist

          it "should have no element", ->
            expect(@data.ret.length).to.eql 0


      context "option 1を選択したとき", ->
        beforeEach ->
          @data.option.set_value "option 1"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should have one element", ->
            expect(@data.ret.length).to.eql 1

          it "should include option 1", ->
            expect(@data.ret).to.include "option 1"

      context "存在しないオプションを選択すると", ->
        beforeEach ->
          @data.func = =>
            @data.option.set_value "option 2"

        it "should throw Error", ->
          expect(@data.func).to.throw Error

    context "3つのオプションを持つとき", ->
      beforeEach ->
        @data.option = new @modules.ParserOptionModel
          type: "multiselect"
          options: [
            "option 1"
            "option 2"
            "option 3"
          ]

      context "何も操作をしないとき", ->
        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should exist", ->
            expect(@data.ret).to.exist

      context "option 1を選択したとき", ->
        beforeEach ->
          @data.option.set_value "option 1"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should have one element", ->
            expect(@data.ret.length).to.eql 1

          it "should include option 1" ,->
            expect(@data.ret).to.include "option 1"

      context "option 3を選択したとき", ->
        beforeEach ->
          @data.option.set_value "option 3"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should have one element", ->
            expect(@data.ret.length).to.eql 1

          it "should include option 3", ->
            expect(@data.ret).to.include "option 3"


      context "option 1とoption2を選択したとき", ->
        beforeEach ->
          @data.option.set_value "option 1"
          @data.option.set_value "option 2"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should have two elements", ->
            expect(@data.ret.length).to.eql 2

          it "should include option 1", ->
            expect(@data.ret).to.include "option 1"

          it "should include option 2", ->
            expect(@data.ret).to.include "option 2"

      context "option 1とoption 3を選択したとき", ->
        beforeEach ->
          @data.option.set_value "option 1"
          @data.option.set_value "option 3"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should have two elements", ->
            expect(@data.ret.length).to.eql 2

          it "should include option 1", ->
            expect(@data.ret).to.include "option 1"

          it "should include option 3", ->
            expect(@data.ret).to.include "option 3"

      context "すべてのオプションを選択して", ->
        beforeEach ->
          @data.option.set_value "option 1"
          @data.option.set_value "option 2"
          @data.option.set_value "option 3"

        context "get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should have three elements", ->
            expect(@data.ret.length).to.eql 3

          it "should include option 1", ->
            expect(@data.ret).to.include "option 1"

          it "should include option 2", ->
            expect(@data.ret).to.include "option 2"

          it "should include option 3", ->
            expect(@data.ret).to.include "option 3"

        context "option 1を選択して", ->
          beforeEach ->
            @data.option.set_value "option 1"

          context "get_value()を実行すると", ->
            beforeEach ->
              @data.ret = @data.option.get_value()

            it "should have two elements", ->
              expect(@data.ret.length).to.eql 2

            it "should not include option 1", ->
              expect(@data.ret).to.not.include "option 1"

            it "should include option 2", ->
              expect(@data.ret).to.include "option 2"

            it "should include option 3", ->
              expect(@data.ret).to.include "option 3"

        context "option 1とoption 3を選択して", ->
          beforeEach ->
            @data.option.set_value "option 1"
            @data.option.set_value "option 3"

          context "get_value()を実行すると", ->
            beforeEach ->
              @data.ret = @data.option.get_value()

            it "should have one element", ->
              expect(@data.ret.length).to.eql 1

            it "should not include option 1", ->
              expect(@data.ret).to.not.include "option 1"

            it "should include option 2", ->
              expect(@data.ret).to.include "option 2"

            it "should not include option 3", ->
              expect(@data.ret).to.not.include "option 3"

      context "存在しないオプションを選択したとき", ->
        beforeEach ->
          @data.func = =>
            @data.option.set_value "option 4"

        it "should throw Error", ->
          expect(@data.func).to.throw Error

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

      context "option 1を追加して", ->
        beforeEach ->
          @data.option.add_option "option 1"

        context "何もせずに", ->
          context "get_value()を実行したとき", ->
            beforeEach ->
              expect(@data.ret).to.eql "option 1"

        context "set_value(option 1)を実行して", ->
          beforeEach ->
            @data.option.set_value "option 1"

          context "get_value()を実行したとき", ->
            beforeEach ->
              expect(@data.ret).to.eql "option 1"

        context "option 2を追加して", ->
          beforeEach ->
            @data.option.add_option "option 2"

          context "何もせずに", ->
            context "get_value()を実行したとき", ->
              beforeEach ->
                expect(@data.ret).to.eql "option 1"

          context "set_value(option 1)を実行して", ->
            beforeEach ->
              @data.option.set_value "option 1"

            context "get_value()を実行したとき", ->
              beforeEach ->
                @data.ret = @data.option.get_value()

              it "should equal option 1", ->
                expect(@data.ret).to.eql "option 1"

          context "set_value(option 2)を実行して", ->
            beforeEach ->
              @data.option.set_value "option 2"

            context "get_value()を実行したとき", ->
              beforeEach ->
                @data.ret = @data.option.get_value()

              it "should equal option 2", ->
                expect(@data.ret).to.eql "option 2"

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

      context "option 2を追加して", ->
        beforeEach ->
          @data.option.add_option "option 2"

        context "何もせずに", ->
          context "get_value()を実行すると", ->
            beforeEach ->
              @data.ret = @data.option.get_value()

            it "should return option 1", ->
              expect(@data.ret).to.eql "option 1"

        context "set_value(option 1)を実行して", ->
          beforeEach ->
            @data.option.set_value "option 1"

          context "get_value()を実行したとき", ->
            beforeEach ->
              @data.ret = @data.option.get_value()

            it "should return option 1", ->
              expect(@data.ret).to.eql "option 1"

        context "set_value(option 2)を実行して", ->
          beforeEach ->
            @data.option.set_value "option 2"

          context "get_value()を実行したとき", ->
            beforeEach ->
              @data.ret = @data.option.get_value()

            it "should return option 2", ->
              expect(@data.ret).to.eql "option 2"

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

