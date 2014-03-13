describe "graph/graph_model", ->
  # load tested modules
  beforeEach (done)=>
    requirejs(
      [
        'graph/graph_model'
      ]
      (
        GraphModel
      )=>
        @graph = new GraphModel
        done()
    )

  context "辺の操作", =>
    # 異なる頂点を接続
    context "グラフに1本の辺を追加する", =>
      # pending
      it "should have one edge"

    context "グラフに1本の辺を追加し、その辺を削除する", =>
      # pending
      it "should have no edge"

