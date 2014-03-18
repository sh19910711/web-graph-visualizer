describe "graph/models/graph_model", ->
  beforeEach (done)->
    requirejs(
      [
        "graph/models/graph_model"
      ]
      (
        GraphModel
      )=>
        @GraphModel = GraphModel
        done()
    )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data


  context "コンストラクタのオプションについて", ->
    context "頂点数を", ->
      context "0個指定したとき", ->
        beforeEach ->
          @data.graph = new @GraphModel
            num_vertices: 0

        it "should have no vertex", ->
          expect(@data.graph.get_num_vertices()).to.equals 0

        it "should have no edge", ->
          expect(@data.graph.get_num_edges()).to.equals 0

      context "1個指定したとき", ->
        beforeEach ->
          @data.graph = new @GraphModel
            num_vertices: 1

        it "should have a vertex", ->
          expect(@data.graph.get_num_vertices()).to.equals 1

        it "should have no edge", ->
          expect(@data.graph.get_num_edges()).to.equals 0

    context "頂点数を3個に指定して", ->
      context "辺を0本指定したとき", ->
        beforeEach ->
          @data.graph = new @GraphModel
            num_vertices: 3
            edges: []

        it "should have three vertices", ->
          expect(@data.graph.get_num_vertices()).to.equals 3

        it "should have no edge", ->
          expect(@data.graph.get_num_edges()).to.equals 0

      context "辺を2本（0-1, 1-2）指定したとき", ->
        beforeEach ->
          @data.graph = new @GraphModel
            num_vertices: 3
            edges: [
              {
                from: 0
                to: 1
              }
              {
                from: 1
                to: 2
              }
            ]

        it "should have three vertices", ->
          expect(@data.graph.get_num_vertices()).to.equals 3

        it "should have two edges", ->
          expect(@data.graph.get_num_edges()).to.equals 2

        it "should exist edge 0-1", ->
          expect(@data.graph.check_edge(0, 1)).to.be.true

        it "should exist edge 1-2", ->
          expect(@data.graph.check_edge(1, 2)).to.be.true


  context "辺の操作について、", ->
    beforeEach ->
      @data.graph = new @GraphModel

    context "2つの頂点を1つの辺0-1で結び、", ->
      beforeEach ->
        # グラフを初期化する
        @data.graph.init 2
        @data.graph.add_edge 0, 1

      context "何もしないとき、", ->
        it "should have one edge", ->
          expect(@data.graph.get_num_edges()).to.equals 1

        it "should exist edge 0-1", ->
          expect(@data.graph.check_edge(0, 1)).to.be.true

      context "辺0-1を削除したとき、", ->
        it "should have no edge", ->
          @data.graph.remove_edge 0, 1
          expect(@data.graph.get_num_edges()).to.equals 0

        it "should exist edge 0-1", ->
          @data.graph.remove_edge 0, 1
          expect(@data.graph.check_edge(0, 1)).to.be.false

      context "辺0-1(既に存在する辺)を追加したとき、", ->
        it "should have one edge", ->
          expect(@graph.get_num_edges()).to.equals 1

