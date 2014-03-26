define(
  [
    "backbone"
    "graph/views/graph_view"
  ]
  (
    Backbone
    GraphView
  )->
    class ContentsView extends Backbone.View
      className: "contents container"

      # 初期化
      # @return [ContentsView] void
      initialize: ->
        # GraphView
        @graph_view = new GraphView
          model: @model.get "graph"

        # グラフが変更されたとき
        @model.on "change:graph", =>
          console.log "change graph"
          @graph_view = new GraphView
            model: @model.get "graph"
          @render()

        @

      # DOMの描画
      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">visualizer</p>'
        @$el.append @graph_view.render().el
        @
)
