define(
  [
    "misc/views/well_view"
  ]
  (
    WellView
  )->
    class ActionsView extends WellView
      events:
        'click .action-btn[data-action="run-visualize"]': "visualize"

      # 視覚化を実行する　
      visualize: =>
        parser = @model.get "parser"
        input_text = @model.get("input_text").get_text() || ""

        # parse()を実行して得られたグラフをモデルに追加
        graph = parser.parse input_text
        @model.set "graph", graph

      # DOMの構築
      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">actions</p>'
        @$el.append '<button data-action="run-visualize" class="action-btn btn btn-lg btn-primary btn-block">Visualize</button>'
        @$el.append '<button disabled class="action-btn btn btn-lg btn-default btn-block">Save as Image</button>'
        @
)
