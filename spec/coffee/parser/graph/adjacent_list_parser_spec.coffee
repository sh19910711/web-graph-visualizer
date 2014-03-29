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
        context "グラフが1つの頂点を持つとき", ->
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

        context "グラフが2つの頂点を持つとき", ->
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
        context "グラフが2つの頂点と1本の辺1-2を持つとき", ->
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

            it "should have a edge", ->
              expect(@data.graph.get_num_edges()).to.eql 1

            it "should have a edge from 0 to 1", ->
              expect(@data.graph.check_edge(0, 1)).to.be.true

            it "should not have a edge from 1 to 0", ->
              expect(@data.graph.check_edge(1, 0)).to.be.false

    context "0-indexedを有効にしたとき", ->
      beforeEach ->
        @data.parser.set_option_value "0-indexed", true

      context "グラフが2つの頂点と1本の辺0-1を持つとき", ->
        beforeEach ->
          @data.input_text = """
2 1
0 1
"""

        context "parse()を実行すると", ->
          beforeEach ->
            @data.graph = @data.parser.parse @data.input_text

          it "should have two vertices", ->
            expect(@data.graph.get_num_vertices()).to.eql 2

          it "should have one edge", ->
            expect(@data.graph.get_num_edges()).to.eql 1

          it "should have edge 0-1", ->
            expect(@data.graph.check_edge(0, 1)).to.be.true

      context "グラフが5つの頂点と4本の辺を持つとき", ->
        beforeEach ->
          @data.input_text = """
5 4
0 1
0 2
0 3
3 4
"""

        context "parse()を実行すると", ->
          beforeEach ->
            @data.graph = @data.parser.parse @data.input_text

          it "should have 5 vertices", ->
            expect(@data.graph.get_num_vertices()).to.eql 5

          it "should have 4 edges", ->
            expect(@data.graph.get_num_edges()).to.eql 4

          it "should have edge 0-1", ->
            expect(@data.graph.check_edge(0, 1)).to.be.true

          it "should have edge 0-2", ->
            expect(@data.graph.check_edge(0, 2)).to.be.true
          
          it "should have edge 0-3", ->
            expect(@data.graph.check_edge(0, 3)).to.be.true

          it "should have edge 3-4", ->
            expect(@data.graph.check_edge(3, 4)).to.be.true

