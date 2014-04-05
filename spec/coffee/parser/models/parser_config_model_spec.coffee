describe "parser/models/parser_config_model", ->
  SpecHelpers.load_modules(
    "parser/graph/graph_parser_example"
    "parser/models/parser_config_model"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  context "parser_config_modelを生成して", ->
    beforeEach ->
      @data.parser_config_model = new @modules.ParserConfigModel

    context "parserのconfigにparser_config_modelを指定して", ->
      beforeEach ->
        @data.parser = new @modules.GraphParserExample
          config: @data.parser_config_model

      context "parserのdummy_1をset_option_valueでnext dummyに変更して", ->
        beforeEach ->
          @data.parser.set_option_value "dummy_1", "next dummy"

        context "parser_config_model.get_value dummy_1を実行すると", ->
          beforeEach ->
            @data.ret = @data.parser_config_model.get_value "dummy_1"

          it "should return value 100", ->
            expect(@data.ret).to.eql "next dummy"

