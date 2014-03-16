define(
  [
    "parser/parser_base"
    "graph/models/graph_model"
  ]
  (
    ParserBase
    GraphModel
  )->
    # パーサー実装のサンプル
    class ParserGraphExample extends ParserBase
      # 固定の結果を返す
      parse: ->
        graph = new GraphModel
        graph.init 5
        graph.add_edge 0, 1
        graph.add_edge 1, 2
        graph.add_edge 3, 4
        graph
)