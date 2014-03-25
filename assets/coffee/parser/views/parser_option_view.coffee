define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    class ParserOptionView extends Backbone.View
      className: "form-group"

      # 初期化
      initialize: ->
        @model.on "change", =>
          @update()

      update: ->
        switch @model.get "type"
          when "text"
            # type=text
            input_tag = @$el.find(".input-text")
            model_value = @model.get_value()
            # モデルとDOMの値が異なるときはDOMの値を設定しなおし
            # changeイベントを発火させる
            input_tag.val(model_value).trigger("change") unless model_value == input_tag.val()
          when "select"
            # type=select
            select_tag = @$el.find(".select-option")
            select_tag.empty()
            _(@model.get "options").each (option)->
              select_tag.append "<option value=\"#{option}\">#{option}</option>"
            model_value = @model.get_value()
            select_tag.val(model_value).trigger("change") unless model_value == select_tag.val()
          else
            throw new Error "ERROR_B90Z1Q: Unknown Parser Option Type"

      # DOMの描画
      render: ->
        @$el.empty()
        switch @model.get "type"
          when "text"
            # type=text
            input_tag = $ '<input type="text" class="input-text form-control">'
            @$el.append input_tag
            input_tag.on "change", =>
              @model.set_value input_tag.val()
          when "select"
            # type=select
            select_tag = $ '<select class="select-option form-control"></select>'
            _(@model.get "options").each (option)->
              select_tag.append "<option value=\"#{option}\">#{option}</option>"
            select_tag.on "change", =>
              @model.set_value select_tag.val() if select_tag.val()
            @$el.append select_tag
          else
            throw new Error "ERROR_EHRPOZ: Unknown Parser Option Type: #{@model.get "type"}"
        @update()
        @
)
