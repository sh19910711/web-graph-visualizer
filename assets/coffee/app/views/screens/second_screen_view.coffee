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

      # 描画を行う
      render: ->
        @$el.empty()
        @$el.append @graph_view.render().el
        @
)
