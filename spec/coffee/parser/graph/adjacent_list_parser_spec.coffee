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

    context "辺が無いグラフを与える場合", ->
      context 'parse("1 0")したとき', ->
        beforeEach ->
          @data.graph = @data.parser.parse("1 0")

        it "graph should have a vertex", ->
          expect(@data.graph.get_num_vertices()).to.eql 1

        it "graph should have no edge", ->
          expect(@data.graph.get_num_edges()).to.eql 0

      context 'parse("2 0")したとき', ->
        beforeEach ->
          @data.graph = @data.parser.parse("2 0")

        it "graph should have two vertices", ->
          expect(@data.graph.get_num_vertices()).to.eql 2

        it "graph should have no edges", ->
          expect(@data.graph.get_num_edges()).to.eql 0

    context "辺が有るグラフを与える場合", ->
      context 'parse("2 1\\n1 2")したとき', ->
        beforeEach ->
          @data.graph = @data.parser.parse("2 1\n1 2")

        it "graph should have two vertices", ->
          expect(@data.graph.get_num_vertices()).to.eql 2

        it "graph should have a edges", ->
          expect(@data.graph.get_num_edges()).to.eql 1

        it "graph should have a edge from 0 to 1", ->
          expect(@data.graph.check_edge(0, 1)).to.be.true

        it "graph should not have a edge from 1 to 0", ->
          expect(@data.graph.check_edge(1, 0)).to.be.false
