define(
  [
    "graph/models/graph_model"
    "backbone"
  ]
  (
    GraphModel
    Backbone
  )->
    class GraphView extends Backbone.View
      initialize: ->
        console.log "@GraphView#initialize"
)
