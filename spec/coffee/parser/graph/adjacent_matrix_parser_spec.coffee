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

    context 'parse("2\\n0 1\\n0 0")したとき', ->
      beforeEach ->
        @data.graph = @data.parser.parse("2\n0 1\n0 0")

      it "graph should have two vertices", ->
        expect(@data.graph.get_num_vertices()).to.eql 2

      it "graph should have a edge", ->
        expect(@data.graph.get_num_edges()).to.eql 1

      it "graph should have a edge from 0 to 0", ->
        expect(@data.graph.check_edge(0, 0)).to.be.false

      it "graph should not have a edge from 0 to 1", ->
        expect(@data.graph.check_edge(0, 1)).to.be.true

      it "graph should not have a edge from 1 to 0", ->
        expect(@data.graph.check_edge(1, 0)).to.be.false

      it "graph should not have a edge from 1 to 1", ->
        expect(@data.graph.check_edge(1, 1)).to.be.false
