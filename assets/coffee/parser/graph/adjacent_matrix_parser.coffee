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
        lines = text.split("\n")
        num_lines = lines.length

        first_line = lines[0]
        num_vertices = parseInt(first_line, 10)

        graph = new GraphModel
        graph.init(num_vertices)

        for i in [0 ... num_vertices]
          line = lines[1 + i].split(" ")
          for j in [0 ... num_vertices]
            c = line[j]
            if c == "1"
              graph.add_edge(i, j)

        graph
)
