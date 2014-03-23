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
        firstLine = lines[0].split(" ")
        num_vertices = parseInt(firstLine[0])
        num_edges = parseInt(firstLine[1])

        graph = new GraphModel
        graph.init(num_vertices)

        graph
)
