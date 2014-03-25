define(
  [
    "parser/parser_base"
    "graph/models/graph_model"
  ]
  (
    ParserBase
    GraphModel
  )->
    # 隣接行列形式の入力を読み込むクラス
    #
    # 対応する入力文字列については
    # spec/parser/graph/adjacent_matrix_parser_spec.coffee
    # を参照すること
    class AdjacentMatrixParser extends ParserBase
      # parse
      # @param [String] text 入力文字列
      # @return [GraphModel] parse後のグラフ
      parse: (text)->
        # TODO: 実装

        lines = text.split("\n")
        num_lines = lines.length

        first_line = lines[0]
        num_vertices = parseInt(first_line, 10)

        graph = new GraphModel
        graph.init(num_vertices)

        graph
)
