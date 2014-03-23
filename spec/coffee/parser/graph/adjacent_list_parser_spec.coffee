describe "coffee/parser/graph/adjacent_list_parser", ->
  SpecHelpers.load_modules(
    "parser/graph/adjacent_list_parser"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  context "parseメソッドについて", ->
    beforeEach ->
      @data.parser = new @modules.AdjacentListParser
    
    context 'parse("1 0")したとき', ->
      beforeEach ->
        @data.graph = @data.parser.parse("1 0")

      it "graph should have a vertex", ->
        expect(@data.graph.get_num_vertices()).to.eql 1

      it "graph should have no edge", ->
        expect(@data.graph.get_num_edges()).to.eql 0
