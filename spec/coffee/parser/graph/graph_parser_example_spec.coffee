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
