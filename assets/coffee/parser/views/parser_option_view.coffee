define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    class ParserOptionView extends Backbone.View
      # 初期化
      initialize: ->

      # DOMの描画
      render: ->
        @$el.empty()
        switch @model.get "type"
          when "text"
            @$el.append "text"
          when "select"
            @$el.append "select"
          else
            throw new Error "ERROR_EHRPOZ: Unknown Parser Option Type"
        @
)
