define(
  [
    "parser/parser_base"
    "parser/models/parser_option_model"
    "graph/models/graph_model"
  ]
  (
    ParserBase
    ParserOptionModel
    GraphModel
  )->
    # 隣接リスト形式の入力を読み込むクラス
    #
    # 対応する入力文字列については
    # spec/parser/graph/adjacent_list_parser_spec.coffee
    # を参照すること
    class AdjacentListParser extends ParserBase
      defaults: ->
        "option/0-indexed": new ParserOptionModel
          type: "flag"
          name: "enable 0-indexed"

      # parse
      # @param [String] text 入力文字列
      # @return [GraphModel] parse後のグラフ
      parse: (text)->
        lines = text.split("\n")
        num_lines = lines.length

        first_line = lines[0].split(" ")
        num_vertices = parseInt(first_line[0], 10)
        num_edges    = parseInt(first_line[1], 10)

        graph = new GraphModel
        graph.init(num_vertices)

        for i in [1 ... num_lines]
          link = lines[i].split(" ")
          from = parseInt(link[0], 10)
          to   = parseInt(link[1], 10)

          if @get_option_value("0-indexed") == false
            from -= 1 # 1-indexed -> 0-indexed
            to   -= 1 # 1-indexed -> 0-indexed

          graph.add_edge(from, to)

        graph
)
