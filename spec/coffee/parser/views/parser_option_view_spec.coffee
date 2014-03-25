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

    context ".input-textにabcdeを設定して", ->
      beforeEach ->
        @data.view.$el.find(".input-text").val "abcde"

      context "option.get_value()を実行すると", ->
        beforeEach ->
          @data.ret = @data.option.get_value()

        it "should be abcde", ->
          expect(@data.ret).to.eql "abcde"

    context "model.set_value abcdeを設定して", ->
      beforeEach ->
        @data.option.set_value "abcde"

      context ".input-textの値を取得すると", ->
        beforeEach ->
          @data.ret = @data.view.$el.find(".input-text").val()

        it "should be abcde", ->
          expect(@data.ret).to.eql "abcde"

