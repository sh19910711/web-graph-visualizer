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
        @data.view.$el.find(".input-text").val("abcde").change()

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
        options: [
          "option 1"
          "option 2"
          "option 3"
        ]
      @data.view = new @modules.ParserOptionView
        model: @data.option
      @data.view.render()

    context ".select-optionにoption 1を設定して", ->
      beforeEach ->
        @data.view.$el.find(".select-option").val("option 1").change()

      context "option.get_value()を実行すると", ->
        beforeEach ->
          @data.ret = @data.option.get_value()

        it "should be option 1", ->
          expect(@data.ret).to.eql "option 1"

    context ".select-optionにoption 2を設定して", ->
      beforeEach ->
        @data.view.$el.find(".select-option").val("option 2").change()

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

