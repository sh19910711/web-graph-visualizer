define(
  [
    "backbone"
    "graph/views/graph_view"
  ]
  (
    Backbone
    GraphView
  )->
    # グラフの視覚化中心
    class SecondView extends Backbone.View
      initialize: ->
        @graph_view = new GraphView
          model: @model.get "graph"

        graph_id = @model.get "graph_id"

        # パーサーを読み込む
        @model.fetch_all_parsers().done =>
          # グラフを読み込む
          input_text = @model.get "input_text"
          input_text.id = graph_id
          parser_config = @model.get "parser_config"
          parser_config.id = graph_id

          deferreds = []
          deferreds.push input_text.fetch()
          deferreds.push parser_config.fetch()

          # グラフの読み込みが完了したとき⎋
          $.when.apply(@, deferreds).done =>
            # 指定されたパーサークラスでインスタンスを生成
            parser_type = parser_config.get "type"
            parsers = @model.get "parsers"
            parser = new parsers[parser_type]
              config: parser_config
            @model.set "parser", parser
            graph = parser.parse input_text.get "text"
            console.log "parsed graph = ", graph
            @model.set "graph", graph

        # グラフに変更があったら再描画を行う
        @model.on "change:graph", =>
          @graph_view = new GraphView
            model: @model.get "graph"
          @render()

      # 描画を行う
      render: ->
        @$el.empty()
        @$el.append @graph_view.render().el
        @
)
