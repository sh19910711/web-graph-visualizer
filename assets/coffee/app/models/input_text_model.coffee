define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    class InputTextModel extends Backbone.Model
      urlRoot: "/api/inputs"
      defaults: ->
        text: ""

      get_text: ->
        @get "text"
)
