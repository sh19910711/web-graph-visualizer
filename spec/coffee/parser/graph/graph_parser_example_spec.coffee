describe "parser/graph/graph_parser_example", ->
  beforeEach (done)->
    requirejs(
      [
        "parser/graph/graph_parser_example"
        "misc/models/select_model"
      ]
      (
        GraphParserExample
        SelectModel
      )=>
        @ParserClass = GraphParserExample
        @SelectModel = SelectModel
        done()
    )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  context "graph_typeについて", ->
    beforeEach ->
      @data.parser = new @ParserClass

    it "should be defined as SelectModel", ->
      expect(@data.parser.graph_type instanceof @SelectModel)

  context "getについて", ->
    beforeEach ->
      @data.parser = new @ParserClass

    context "何もせず", ->
      context "key1を取得したとき", ->
        beforeEach ->
          @data.ret = @data.parser.get "key1"

        it "should return value1", ->
          expect(@data.ret).to.equals "value1"

      context "key2を取得したとき", ->
        beforeEach ->
          @data.ret = @data.parser.get "key2"

        it "should return value2", ->
          expect(@data.ret).to.equals "value2"

      context "key3を取得したとき", ->
        beforeEach ->
          @data.ret = @data.parser.get "key3"

        it "should return undefined", ->
          expect(@data.ret).to.equals undefined

    context "set key1, new_value1を実行して", ->
      beforeEach ->
        @data.parser.set "key1", "new_value1"

      context "key1を取得したとき", ->
        beforeEach ->
          @data.ret = @data.parser.get "key1"

        it "should return new_value1", ->
          expect(@data.ret).to.equals "new_value1"

      context "key2を取得したとき", ->
        beforeEach ->
          @data.ret = @data.parser.get "key2"

        it "should return value2", ->
          expect(@data.ret).to.equals "value2"

      context "key3を取得したとき", ->
        beforeEach ->
          @data.ret = @data.parser.get "key3"

        it "should return undefined", ->
          expect(@data.ret).to.equals undefined

    context "set key3, new_value3を実行して", ->
      beforeEach ->
        @data.parser.set "key3", "new_value3"

      context "key1を取得したとき", ->
        beforeEach ->
          @data.ret = @data.parser.get "key1"

        it "should return value1", ->
          expect(@data.ret).to.equals "value1"

      context "key2を取得したとき", ->
        beforeEach ->
          @data.ret = @data.parser.get "key2"

        it "should return value2", ->
          expect(@data.ret).to.equals "value2"

      context "key3を取得したとき", ->
        beforeEach ->
          @data.ret = @data.parser.get "key3"

        it "should return new_value3", ->
          expect(@data.ret).to.equals "new_value3"
  
  context "parseメソッドについて", ->
    beforeEach ->
      @data.parser = new @ParserClass
      
    context "parse(this is test)したとき", ->
      beforeEach ->
        @data.graph = @data.parser.parse("this is test")
      
      it "should return fixed value", ->
        expect(@data.graph.get_num_vertices()).to.equals 5
        expect(@data.graph.get_num_edges()).to.equals 3
    
    context "parse(1 2 3 4 5)したとき", ->
      beforeEach ->
        @data.graph = @data.parser.parse("1 2 3 4 5")
        
      it "should return fixed value", ->
        expect(@data.graph.get_num_vertices()).to.equals 5
        expect(@data.graph.get_num_edges()).to.equals 3
    
    context "parse(aaaaaa)したとき", ->
      beforeEach ->
        @data.graph = @data.parser.parse("aaaaaa")
        
      it "should return fixed value", ->
        expect(@data.graph.get_num_vertices()).to.equals 5
        expect(@data.graph.get_num_edges()).to.equals 3
