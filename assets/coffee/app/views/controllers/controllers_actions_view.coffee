define(
  [
    "./well_view"
  ]
  (
    WellView
  )->
    # アクション
    class ControllersActionsView extends WellView
      initialize: ->
        @

      # DOMイベント
      events:
        'click .action-btn[data-action="run-visualize"]': "visualize"

      # 視覚化
      visualize: =>
        parser = @model.get "parser"
        input_text = @model.get("input_text") || ""

        # parse()を実行して得られたグラフをモデルに送信
        graph = parser.parse input_text
        @model.set "graph", graph

      # DOMの描画
      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">actions</p>'
        @$el.append '<button data-action="run-visualize" class="action-btn btn btn-lg btn-primary btn-block">Visualize</button>'
        @$el.append '<button disabled class="action-btn btn btn-lg btn-default btn-block">Save as Image</button>'
        @
)
