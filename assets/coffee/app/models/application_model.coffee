define(
  [
    "backbone"
    "graph/models/graph_model"
  ]
  (
    Backbone
    GraphModel
  )->
    class ApplicationModel extends Backbone.Model
      # 初期化
      initialize: ->
        console.log "@ApplicationModel#initialize"

        # GraphModelの初期化
        graph = new GraphModel
        @set "graph", graph

        # ダミーのデータを入れておく
        # TODO: 入力文字列から受け取れるようにする
        # 5つの頂点と3本の辺
        graph.init 5
        graph.add_edge 0, 1
        graph.add_edge 1, 2
        graph.add_edge 3, 4

        @
)
