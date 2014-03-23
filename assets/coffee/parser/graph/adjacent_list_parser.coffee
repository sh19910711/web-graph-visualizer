define(
  [
    "parser/parser_base"
    "graph/models/graph_model"
  ]
  (
    ParserBase
    GraphModel
  )->
    # 隣接リスト形式の入力を読み込むクラス
    #
    # 対応する入力文字列については
    # spec/parser/graph/adjacent_list_parser_spec.coffee
    # を参照すること
    class AdjacentListParser extends ParserBase
      # parse
      # @param [String] text 入力文字列
      # @return [GraphModel] parse後のグラフ
      parse: (text)->
        graph = new GraphModel
          num_vertices: 1
          edges: []
        # TODO: 実装
        graph
)
