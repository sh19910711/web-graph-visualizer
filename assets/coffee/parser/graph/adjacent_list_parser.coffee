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
        # TODO: 実装

        lines = text.split("\n")
        num_lines = lines.length

        first_line = lines[0].split(" ")
        num_vertices = parseInt(first_line[0], 10)
        num_edges    = parseInt(first_line[1], 10)

        graph = new GraphModel
        graph.init(num_vertices)

        for i in [1 ... num_lines]
          link = lines[i].split(" ")
          from = parseInt(link[0], 10) - 1 # 1-indexed -> 0-indexed
          to   = parseInt(link[1], 10) - 1 # 1-indexed -> 0-indexed

          graph.add_edge(from, to)

        graph
)
