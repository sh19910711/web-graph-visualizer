define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    class FormControlView extends Backbone.View
      className: "form-control"

      set_placeholder: (text)->
        @$el.prop "placeholder", text
)
