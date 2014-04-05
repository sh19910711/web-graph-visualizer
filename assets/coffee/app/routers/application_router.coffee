define(
  [
    "backbone"
    "jquery"
    "app/models/application_model"
    "app/views/application_view"
    "app/models/input_text_model"
    "parser/models/parser_config_model"
  ]
  (
    Backbone
    $
    ApplicationModel
    ApplicationView
    InputTextModel
    ParserConfigModel
  )->
    class ApplicationRouter extends Backbone.Router
      # ルーティング
      routes:
        "": "show_index"
        "graphs/:graph_id": "show_graph"

      # グラフを描画する画面
      show_graph: (graph_id)->
        model = new ApplicationModel
          "page.title": "Graph Visualizer - Graph"
          "page.desc": "test"

        view = new ApplicationView
          model: model

        $("body").empty().append view.render().el

        # availableなパーサを読み込み
        requirejs(
          [
            "parser/graph/graph_parser_example"
            "parser/graph/adjacent_list_parser"
            "parser/graph/adjacent_matrix_parser"
          ]
          =>
            # parsers[class name] = class
            parsers = _(arguments).reduce(
              (prev, ParserClass)->
                obj = {}
                obj[ParserClass.name] = ParserClass
                _(prev).extend obj
              {}
            )

            # パーサを読み込み終わったら、指定されたIDでInputTextModelとParserConfigModelをfetch()する
            deferreds = []

            input_text = new InputTextModel
              id: graph_id
            deferreds.push input_text.fetch()
            model.set "input_text", input_text

            parser_config = new ParserConfigModel
              id: graph_id
            deferreds.push parser_config.fetch()
            model.set "parser_config", parser_config

            $.when.apply(@, deferreds).done =>
              # fetch()に成功したらパーサーのインスタンスを生成
              parser = new parsers[parser_config.get "type"]
                config: parser_config

              model.set "parser", parser

              # parse()を実行してGraphModelを更新
              graph = parser.parse input_text.get "text"
              model.set "graph", graph
        )

      # 初期画面
      show_index: ->
        # ApplicationModelの初期化
        model = new ApplicationModel
          "page.title": "Graph Visualizer - Home"
          "page.desc": "工事中（under construction）"

        # ApplicationViewの初期化
        view = new ApplicationView
          model: model

        $("body").empty().append view.render().el
)
