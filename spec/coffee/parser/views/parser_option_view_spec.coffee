describe "parser/views/parser_option_view", ->
  SpecHelpers.load_modules(
    "parser/models/parser_option_model"
    "parser/views/parser_option_view"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  context "typeがtextのときについて", ->
    beforeEach ->
      @data.option = new @modules.ParserOptionModel
        type: "text"
      @data.view = new @modules.ParserOptionView
        model: @data.option
      @data.view.render()

    context ".input-textにabcdeを設定して", ->
      beforeEach ->
        @data.view.$el.find(".input-text").val("abcde").trigger("change")

      context "option.get_value()を実行すると", ->
        beforeEach ->
          @data.ret = @data.option.get_value()

        it "should be abcde", ->
          expect(@data.ret).to.eql "abcde"

    context "option.set_value abcdeを設定して", ->
      beforeEach ->
        @data.option.set_value "abcde"

      context ".input-textの値を取得すると", ->
        beforeEach ->
          @data.ret = @data.view.$el.find(".input-text").val()

        it "should be abcde", ->
          expect(@data.ret).to.eql "abcde"

  context "typeがhiddenのときについて", ->
    beforeEach ->
      @data.option = new @modules.ParserOptionModel
        type: "hidden"
      @data.view = new @modules.ParserOptionView
        model: @data.option
      @data.view.render()

    context ".input-textにabcdeを設定して", ->
      beforeEach ->
        @data.view.$el.find(".input-text").val("abcde").trigger("change")

      context "option.get_value()を実行すると", ->
        beforeEach ->
          @data.ret = @data.option.get_value()

        it "should be abcde", ->
          expect(@data.ret).to.eql "abcde"

    context "option.set_value abcdeを設定して", ->
      beforeEach ->
        @data.option.set_value "abcde"

      context ".input-textの値を取得すると", ->
        beforeEach ->
          @data.ret = @data.view.$el.find(".input-text").val()

        it "should be abcde", ->
          expect(@data.ret).to.eql "abcde"

  context "typeがselectのときについて", ->
    beforeEach ->
      @data.option = new @modules.ParserOptionModel
        type: "select"
      @data.view = new @modules.ParserOptionView
        model: @data.option
      @data.view.render()

    context "3つのオプションを持つとき", ->
      beforeEach ->
        @data.option.set_select_options(
          [
            "option 1"
            "option 2"
            "option 3"
          ]
        )

      context ".select-optionにoption 1を設定して", ->
        beforeEach ->
          @data.view.$el.find(".select-option").val("option 1").trigger("change")

        context "option.get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should be option 1", ->
            expect(@data.ret).to.eql "option 1"

      context ".select-optionにoption 2を設定して", ->
        beforeEach ->
          @data.view.$el.find(".select-option").val("option 2").trigger("change")

        context "option.get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should be option 2", ->
            expect(@data.ret).to.eql "option 2"

      context "option.set_value option 1を実行して", ->
        beforeEach ->
          @data.option.set_value "option 1"

        context "(.select-option).val()を実行すると", ->
          beforeEach ->
            @data.ret = @data.view.$el.find(".select-option").val()

          it "should be option 1", ->
            expect(@data.ret).to.eql "option 1"

      context "option.set_value option 2を実行して", ->
        beforeEach ->
          @data.option.set_value "option 2"

        context "(.select-option).val()を実行すると", ->
          beforeEach ->
            @data.ret = @data.view.$el.find(".select-option").val()

          it "should be option 2", ->
            expect(@data.ret).to.eql "option 2"

  context "typeがmultiselectのときについて", ->
    beforeEach ->
      @data.option = new @modules.ParserOptionModel
        type: "multiselect"
      @data.view = new @modules.ParserOptionView
        model: @data.option
      @data.view.render()

    context "3つのオプションを持つとき", ->
      beforeEach ->
        @data.option.set(
          "options"
          [
            "option 1"
            "option 2"
            "option 3"
          ]
        )

      context "option.set_value(option 1)を実行して", ->
        beforeEach ->
          @data.option.set_value "option 1"

        context "$(.multiselect-option:checked)を実行すると", ->
          beforeEach ->
            @data.ret = []
            @data.view.$el.find(".multiselect-option:checked").each (k, element)=>
              @data.ret.push $(element).val()

          it "should have option 1", ->
            expect(@data.ret).to.include "option 1"

          it "should have one element", ->
            expect(@data.ret.length).to.eql 1

      context "option.set_value(option 1)とoption.set_value(option 2)を実行して", ->
        beforeEach ->
          @data.option.set_value "option 1"
          @data.option.set_value "option 2"

        context "$(.multiselect-option:checked)を実行すると", ->
          beforeEach ->
            @data.ret = []
            @data.view.$el.find(".multiselect-option:checked").each (k, element)=>
              @data.ret.push $(element).val()

          it "should have option 1", ->
            expect(@data.ret).to.include "option 1"

          it "should have option 2", ->
            expect(@data.ret).to.include "option 2"

          it "should have two elements", ->
            expect(@data.ret.length).to.eql 2

      context "[value=option 1]をチェックして", ->
        beforeEach ->
          @data.view.$el.find('.multiselect-option[value="option 1"]').prop("checked", true).trigger "change"

        context "option.get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should have one element", ->
            expect(@data.ret.length).to.eql 1

          it "should have option 1", ->
            expect(@data.ret).to.include "option 1"

      context "[value=option 1]と[value=option 3]をチェックして", ->
        beforeEach ->
          @data.view.$el.find('.multiselect-option[value="option 1"]').prop("checked", true).trigger "change"
          @data.view.$el.find('.multiselect-option[value="option 3"]').prop("checked", true).trigger "change"

        context "option.get_value()を実行すると", ->
          beforeEach ->
            @data.ret = @data.option.get_value()

          it "should have two elements", ->
            expect(@data.ret.length).to.eql 2

          it "should have option 1", ->
            expect(@data.ret).to.include "option 1"

          it "should have option 3", ->
            expect(@data.ret).to.include "option 3"

  context "typeがflagのときについて", ->
    beforeEach ->
      @data.option = new @modules.ParserOptionModel
        type: "flag"
        name: "dummy"
      @data.view = new @modules.ParserOptionView
        model: @data.option
      @data.view.render()

    context "何もせずに", ->
      context "$(.checked).prop(checked)を実行すると", ->
        beforeEach ->
          @data.ret = @data.view.$el.find(".flag").prop "checked"

        it "should be false", ->
          expect(@data.ret).to.be.false

    context "option.set_value()を実行して", ->
      beforeEach ->
        @data.option.set_value()

      context "$(.checkbox).prop(checked)を実行すると", ->
        beforeEach ->
          @data.ret = @data.view.$el.find(".flag").prop "checked"

        it "should be true", ->
          expect(@data.ret).to.be.true

    context "option.set_value(false)を実行して", ->
      beforeEach ->
        @data.option.set_value false

      context "$(.checkbox).prop(checked)を実行すると", ->
        beforeEach ->
          @data.ret = @data.view.$el.find(".flag").prop "checked"

        it "should be false", ->
          expect(@data.ret).to.be.false

