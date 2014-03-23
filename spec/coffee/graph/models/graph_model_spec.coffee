describe "graph/models/graph_model", ->
  SpecHelpers.load_modules(
    "graph/models/graph_model"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data


  context "コンストラクタのオプションについて", ->
    context "頂点数を0個に指定したとき", ->
      beforeEach ->
        @data.graph = new @modules.GraphModel
          num_vertices: 0

      it "should have no vertex", ->
        expect(@data.graph.get_num_vertices()).to.eql 0

      it "should have no edge", ->
        expect(@data.graph.get_num_edges()).to.eql 0

    context "頂点数を1個に指定したとき", ->
      beforeEach ->
        @data.graph = new @modules.GraphModel
          num_vertices: 1

      it "should have a vertex", ->
        expect(@data.graph.get_num_vertices()).to.eql 1

      it "should have no edge", ->
        expect(@data.graph.get_num_edges()).to.eql 0

    context "頂点数を3個に指定して", ->
      context "辺を0本指定したとき", ->
        beforeEach ->
          @data.graph = new @modules.GraphModel
            num_vertices: 3
            edges: []

        it "should have three vertices", ->
          expect(@data.graph.get_num_vertices()).to.eql 3

        it "should have no edge", ->
          expect(@data.graph.get_num_edges()).to.eql 0

      context "辺を2本（0-1, 1-2）指定したとき", ->
        beforeEach ->
          @data.graph = new @modules.GraphModel
            num_vertices: 3
            edges: [
              { from: 0, to: 1 }
              { from: 1, to: 2 }
            ]

        it "should have three vertices", ->
          expect(@data.graph.get_num_vertices()).to.eql 3

        it "should have two edges", ->
          expect(@data.graph.get_num_edges()).to.eql 2

        it "should exist edge 0-1", ->
          expect(@data.graph.check_edge(0, 1)).to.be.true

        it "should exist edge 1-2", ->
          expect(@data.graph.check_edge(1, 2)).to.be.true


  context "辺の操作について、", ->
    beforeEach ->
      @data.graph = new @modules.GraphModel

    context "2つの頂点を1つの辺0-1で結び、", ->
      beforeEach ->
        # グラフを初期化する
        @data.graph.init 2
        @data.graph.add_edge 0, 1

      context "何もしないとき、", ->
        it "should have one edge", ->
          expect(@data.graph.get_num_edges()).to.eql 1

        it "should exist edge 0-1", ->
          expect(@data.graph.check_edge(0, 1)).to.be.true

      context "辺0-1を削除したとき、", ->
        beforeEach ->
          @data.graph.remove_edge 0, 1
          
        it "should have no edge", ->
          expect(@data.graph.get_num_edges()).to.eql 0

        it "should exist edge 0-1", ->
          expect(@data.graph.check_edge(0, 1)).to.be.false

      context "辺0-1(既に存在する辺)を追加したとき、", ->
        beforeEach ->
          @data.graph.add_edge 0, 1
          
        it "should have one edge", ->
          expect(@data.graph.get_num_edges()).to.eql 1

  context "get_edgesメソッドについて", ->
    context "頂点数を3個、辺を2本（0-1, 1-2）指定して", ->
      beforeEach ->
        @data.graph = new @modules.GraphModel
          num_vertices: 3
          edges: [
            { from: 0, to: 1 }
            { from: 1, to: 2 }
          ]

      context "get_edges(source, target)を実行したとき", ->
        beforeEach ->
          @ret = @data.graph.get_edges("source", "target")

        it "should return list of {source, target}", ->
          expect(@ret).to.eql [
              { source: 0, target: 1 }
              { source: 1, target: 2 }
            ]

      context "get_edges(A, B)を実行したとき", ->
        beforeEach ->
          @ret = @data.graph.get_edges("A", "B")

        it "should return list of {A, B}", ->
          expect(@ret).to.eql [
              { A: 0, B: 1 }
              { A: 1, B: 2 }
            ]

      context "get_edges()を実行したとき", ->
        beforeEach ->
          @ret = @data.graph.get_edges()

        it "should return list of {from, to}", ->
          expect(@ret).to.eql [
              { from: 0, to: 1 }
              { from: 1, to: 2 }
            ]

    context "頂点数を3個指定して", ->
      beforeEach ->
        @data.graph = new @modules.GraphModel
          num_vertices: 3

      context "add_edge(0, 1)を実行して", ->
        beforeEach ->
          @data.graph.add_edge 0, 1

        context "get_edges(source, target)を実行したとき", ->
          beforeEach ->
            @ret = @data.graph.get_edges("source", "target")

          it "should return list of {source, target}", ->
            expect(@ret).to.eql [
                { source: 0, target: 1 }
              ]

        context "get_edges()を実行したとき", ->
          beforeEach ->
            @ret = @data.graph.get_edges()

          it "should return list of {from, to}", ->
            expect(@ret).to.eql [
                { source: 0, target: 1 }
              ]

      context "get_edges(source, target)を実行したとき", ->
        beforeEach ->
          @ret = @data.graph.get_edges("source", "target")

        it "should return empty list", ->
          expect(@ret).to.eql []

      context "get_edges()を実行したとき", ->
        beforeEach ->
          @ret = @data.graph.get_edges()

        it "should return empty", ->
          expect(@ret).to.eql []

