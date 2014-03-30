define(
  [
    "backbone"
    "./textarea_view"
  ]
  (
    Backbone
    TextAreaView
  )->
    # 入力欄
    class ControllersTextAreaView extends Backbone.View
      className: "form-group"

      initialize: ->
        @textarea = new TextAreaView
          model: @model
        @textarea.$el.attr "rows", "14"

        # 内容が変更されたらモデルに送信
        @textarea.$el.on "change", =>
          @model.set "input_text", @textarea.$el.val()

        # パーサーの種類が変更されたとき
        @model.on "change:parser", =>
          parser = @model.get "parser"
          # サンプル入力があればそれをplaceholderに設定する
          try
            example_input = parser.get_example_input()
            @textarea.$el.attr "placeholder", example_input
          catch
            @textarea.$el.attr "placeholder", "input text"

        @

      render: ->
        @$el.empty()
        @$el.append @textarea.render().el
        @
)
