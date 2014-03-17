describe "graph/models/graph_model", ->
  # load tested modules
  beforeEach (done)=>
    requirejs(
      [
        'graph/models/graph_model'
      ]
      (
        GraphModel
      )=>
        @GraphModel = GraphModel
        done()
    )

  context "辺の操作について、", =>
    beforeEach =>
      # グラフの準備
      @graph = new @GraphModel
      
    context "2つの頂点を1つの辺0-1で結び、", =>
      beforeEach =>
        # グラフを初期化する
        @graph.init 2
        @graph.add_edge 0, 1
      
      context "何もしないとき、", =>
        it "should have one edge", =>
          expect(@graph.get_num_edges()).to.equals 1
          
        it "should exist edge 0-1", =>
          expect(@graph.check_edge(0, 1)).to.be.true
            
      context "辺0-1を削除したとき、", =>
        it "should have no edge", =>
          @graph.remove_edge 0, 1
          expect(@graph.get_num_edges()).to.equals 0
          
        it "should exist edge 0-1", =>
          @graph.remove_edge 0, 1
          expect(@graph.check_edge(0, 1)).to.be.false

      context "辺0-1(既に存在する辺)を追加したとき、", =>
        it "should have one edge", =>
          expect(@graph.get_num_edges()).to.equals 1
