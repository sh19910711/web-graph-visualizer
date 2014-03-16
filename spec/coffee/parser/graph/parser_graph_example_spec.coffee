describe "parser/graph/parser_graph_example", ->
  beforeEach (done)=>
    requirejs(
      [
        "parser/graph/parser_graph_example"
      ]
      (
        ParserGraphExample
      )=>
        @ParserClass = ParserGraphExample
        done()
    )
  
  context "parseメソッドについて", =>
    beforeEach =>
      @parser = new @ParserClass
      
    it "should return fixed value", =>
      expect(@parser.parse("this is test").get_num_vertices()).to.equals 5
      expect(@parser.parse("this is test").get_num_edges()).to.equals 3
      
    it "should return fixed value", =>
      expect(@parser.parse("1 2 3 4 5").get_num_vertices()).to.equals 5
      expect(@parser.parse("this is test").get_num_edges()).to.equals 3
      
    it "should return fixed value", =>
      expect(@parser.parse("aaaaaa").get_num_vertices()).to.equals 5
      expect(@parser.parse("this is test").get_num_edges()).to.equals 3
