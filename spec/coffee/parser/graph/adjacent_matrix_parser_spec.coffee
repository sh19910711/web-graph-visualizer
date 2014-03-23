describe "coffee/parser/graph/adjacent_matrix_parser", ->
  SpecHelpers.load_modules(
    "parser/graph/adjacent_matrix_parser"
  )

  beforeEach ->
    @data = {}
  
  afterEach ->
    delete @data

  context "parseメソッドについて", ->
    beforeEach ->
      @data.parser = new @modules.AdjacentMatrixParser
  
    context 'parse("1\\n0")したとき', ->
      beforeEach ->
        @data.graph = @data.parser.parse("1\n0")

      it "graph should have a vertex", ->
        expect(@data.graph.get_num_vertices()).to.eql 1

      it "graph should have no edge", ->
        expect(@data.graph.get_num_edges()).to.eql 0

    context 'parse("2\\n0 0\\n0 0")したとき', ->
      beforeEach ->
        @data.graph = @data.parser.parse("2\n0 0\n0 0")

      it "graph should have two vertices", ->
        expect(@data.graph.get_num_vertices()).to.eql 2

      it "graph should have no edge", ->
        expect(@data.graph.get_num_edges()).to.eql 0
