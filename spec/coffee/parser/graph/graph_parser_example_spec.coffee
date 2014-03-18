describe "parser/graph/graph_parser_example", ->
  beforeEach (done)=>
    requirejs(
      [
        "parser/graph/graph_parser_example"
      ]
      (
        GraphParserExample
      )=>
        @ParserClass = GraphParserExample
        done()
    )

  context "get_optionについて", =>
    beforeEach =>
      @parser = new @ParserClass
      console.log @parser.__options

    context "何もしないとき", =>
      context "key1を取得すると", =>
        beforeEach =>
          @ret = @parser.get_option "key1"

        it "should return value1", =>
          expect(@ret).to.equals "value1"

      context "key2を取得すると", =>
        beforeEach =>
          @ret = @parser.get_option "key2"

        it "should return value2", =>
          expect(@ret).to.equals "value2"

      context "key3を取得すると", =>
        beforeEach =>
          @ret = @parser.get_option "key3"

        it "should return undefined", =>
          expect(@ret).to.equals undefined

    context "set_option key1, new_value1を実行したとき", =>
      beforeEach =>
        @parser.set_option "key1", "new_value1"

      context "key1を取得すると", =>
        beforeEach =>
          @ret = @parser.get_option "key1"

        it "should return new_value1", =>
          expect(@ret).to.equals "new_value1"

      context "key2を取得すると", =>
        beforeEach =>
          @ret = @parser.get_option "key2"

        it "should return value2", =>
          expect(@ret).to.equals "value2"

      context "key3を取得すると", =>
        beforeEach =>
          @ret = @parser.get_option "key3"

        it "should return undefined", =>
          expect(@ret).to.equals undefined

    context "set_option key3, new_value3を実行したとき", =>
      beforeEach =>
        @parser.set_option "key3", "new_value3"

      context "key1を取得すると", =>
        beforeEach =>
          @ret = @parser.get_option "key1"

        it "should return value1", =>
          expect(@ret).to.equals "value1"

      context "key2を取得すると", =>
        beforeEach =>
          @ret = @parser.get_option "key2"

        it "should return value2", =>
          expect(@ret).to.equals "value2"

      context "key3を取得すると", =>
        beforeEach =>
          @ret = @parser.get_option "key3"

        it "should return new_value3", =>
          expect(@ret).to.equals "new_value3"
  
  context "parseメソッドについて", =>
    beforeEach =>
      @parser = new @ParserClass
      
    context "parse(this is test)したとき", =>
      beforeEach =>
        @graph = @parser.parse("this is test")
      
      it "should return fixed value", =>
        expect(@graph.get_num_vertices()).to.equals 5
        expect(@graph.get_num_edges()).to.equals 3
    
    context "parse(1 2 3 4 5)したとき", =>
      beforeEach =>
        @graph = @parser.parse("1 2 3 4 5")
        
      it "should return fixed value", =>
        expect(@graph.get_num_vertices()).to.equals 5
        expect(@graph.get_num_edges()).to.equals 3
    
    context "parse(aaaaaa)したとき", =>
      beforeEach =>
        @graph = @parser.parse("aaaaaa")
        
      it "should return fixed value", =>
        expect(@graph.get_num_vertices()).to.equals 5
        expect(@graph.get_num_edges()).to.equals 3
