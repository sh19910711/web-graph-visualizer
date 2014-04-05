define(
  [
    "backbone"
    "underscore"
    "graph/models/graph_model"
    "misc/models/select_model"
    "misc/models/item_model"
    "misc/collections/item_collection"
  ]
  (
    Backbone
    _
    GraphModel
    SelectModel
    ItemModel
    ItemCollection
  )->
    class ApplicationModel extends Backbone.Model
      defaults: ->
        parsers: {}

      # 初期化
      initialize: ->
        # GraphModelの初期化
        graph = new GraphModel
        @set "graph", graph

        parser_keys = new ItemCollection []
        parser_select = new SelectModel
          items: parser_keys
        @set "parser_select", parser_select
        @set "parser", undefined
        # パーサーが選択されたらパーサーのインスタンスを作り直す
        parser_select.on "change:selected_id", =>
          parsers = @get "parsers"
          selected_id = parser_select.get "selected_id"
          @set "parser", new parsers[selected_id] if parsers[selected_id] instanceof Function

        # パーサーの読み込み
        requirejs(
          [
            "parser/graph/graph_parser_example"
            "parser/graph/adjacent_list_parser"
            "parser/graph/adjacent_matrix_parser"
          ]
          =>
            parsers = _(arguments).reduce(
              (prev, ParserClass)->
                # キーを登録
                parser_keys.add
                  id: ParserClass.name
                  value: ParserClass.name
                obj = {}
                obj[ParserClass.name] = ParserClass
                _(prev).extend obj
              {}
            )
            @set "parser", new arguments[0] if arguments.length > 0
            @set "parsers", parsers
        )

        graph.init 0

        @
)
