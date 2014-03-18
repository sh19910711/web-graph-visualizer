describe "graph/models/graph_model", ->
  # load tested modules
  beforeEach (done)->
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

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

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

