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

    context "デフォルトの設定について", ->
      context "辺が無いグラフを与える場合", ->
        context "1つの頂点を持つとき", ->
          beforeEach ->
            @data.input_text = """
1 0
"""

          context 'parse()を実行すると', ->
            beforeEach ->
              @data.graph = @data.parser.parse @data.input_text

            it "should have a vertex", ->
              expect(@data.graph.get_num_vertices()).to.eql 1

            it "should have no edge", ->
              expect(@data.graph.get_num_edges()).to.eql 0

        context "2つの頂点を持つとき", ->
          beforeEach ->
            @data.input_text = """
2 0
"""

          context 'parse()を実行すると', ->
            beforeEach ->
              @data.graph = @data.parser.parse @data.input_text

            it "should have two vertices", ->
              expect(@data.graph.get_num_vertices()).to.eql 2

            it "should have no edges", ->
              expect(@data.graph.get_num_edges()).to.eql 0

      context "辺が有るグラフを与える場合", ->
        context "2つの頂点と1本の辺1-2を持つとき", ->
          beforeEach ->
            @data.input_text = """
2 1
1 2
"""

          context "parse()を実行すると", ->
            beforeEach ->
              @data.graph = @data.parser.parse @data.input_text

            it "should have two vertices", ->
              expect(@data.graph.get_num_vertices()).to.eql 2

            it "should have a edges", ->
              expect(@data.graph.get_num_edges()).to.eql 1

            it "should have a edge from 0 to 1", ->
              expect(@data.graph.check_edge(0, 1)).to.be.true

            it "should not have a edge from 1 to 0", ->
              expect(@data.graph.check_edge(1, 0)).to.be.false

