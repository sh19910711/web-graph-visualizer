define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    # textarea
    class TextAreaView extends Backbone.View
      tagName: "textarea"
      className: "form-control"

      initialize: ->
        @$el.css
          maxWidth: "100%"
          width: "100%"
        @

      render: ->
        @
)
