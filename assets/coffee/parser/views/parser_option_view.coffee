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
        @model.on "change", =>
          @update()

      update: ->
        switch @model.get "type"
          when "text"
            input_tag = @$el.find(".input-text")
            model_value = @model.get "value"
            # モデルとDOMの値が異なるときはDOMの値を設定しなおし
            # changeイベントを発火させる
            input_tag.val(model_value).change() unless model_value == input_tag.val()
          when "select"
          else
            throw new Error "ERROR_B90Z1Q: Unknown Parser Option Type"

      # DOMの描画
      render: ->
        @$el.empty()
        switch @model.get "type"
          when "text"
            input_tag = $ '<input type="text" class="input-text form-control">'
            @$el.append input_tag
            input_tag.on "change", =>
              @model.set "value", input_tag.val()
          when "select"
            @$el.append "select"
          else
            throw new Error "ERROR_EHRPOZ: Unknown Parser Option Type"
        @update()
        @
)
