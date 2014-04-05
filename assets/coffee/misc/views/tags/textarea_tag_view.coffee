define(
  [
    "misc/views/form_control_view"
  ]
  (
    FormControlView
  )->
    # textarea
    class TextareaTagView extends FormControlView
      tagName: "textarea"

      # 初期化
      initialize: ->
        @$el.css
          maxWidth: "100%"
          minWidth: "100%"
          width: "100%"
        @
)
