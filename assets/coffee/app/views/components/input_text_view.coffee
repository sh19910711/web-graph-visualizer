define(
  [
    "backbone"
    "misc/views/tags/textarea_tag_view"
  ]
  (
    Backbone
    TextareaTagView
  )->
    # 入力用
    class InputTextView extends Backbone.View
      className: "form-group"

      # 初期化
      initialize: ->
        @input_text_model = @model.get "input_text"

        @textarea = new TextareaTagView
        @textarea.$el.prop "rows", 14

        # テキストエリアの内容が変更されたらinput_text_modelに内容を送信する
        @textarea.$el.on "change", =>
          @input_text_model.set "text", @textarea.$el.val()

        # パーサーの種類が変更されたとき
        @model.on "change:parser", =>
          # サンプル入力があればそれをplaceholderとして設定する
          parser = @model.get "parser"
          try
            example_input = parser.get_example_input()
            @textarea.set_placeholder example_input
          catch
            @textarea.set_placeholder "input text"


      # DOMの構築
      render: ->
        @$el
          .empty()
          .append @textarea.render().el
        @

)
