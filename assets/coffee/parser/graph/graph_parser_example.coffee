define(
  [
    "parser/parser_base"
    "graph/models/graph_model"
    "misc/models/select_model"
  ]
  (
    ParserBase
    GraphModel
    SelectModel
  )->
    # パーサー実装のサンプル
    class GraphParserExample extends ParserBase
      # デフォルトオプション
      defaults:
        key1: "value1"
        key2: "value2"

      # 初期化
      initialize: ->
        # 出力するグラフの種類
        @graph_type = new SelectModel
          items: [
            "GRAPH_TYPE_0"
            "GRAPH_TYPE_1"
          ]
          selected_key: 0

      # 固定の結果を返す
      parse: ->
        graph = new GraphModel
        switch @graph_type.get "selected_key"
          when 0
            # 5個の頂点と3本の辺
            graph.init 5
            graph.add_edge 0, 1
            graph.add_edge 1, 2
            graph.add_edge 3, 4

          when 1
            # 10個の頂点と8本の辺
            graph.init 10
            graph.add_edge 0, 1
            graph.add_edge 1, 2
            graph.add_edge 1, 3
            graph.add_edge 1, 4
            graph.add_edge 5, 6
            graph.add_edge 6, 7
            graph.add_edge 7, 8
            graph.add_edge 7, 9

          else
            throw new Error "ERROR_Q3ORKH: Unknown Graph Type"

        graph
)
