define(
  [
    "misc/views/well_view"
    "parser/views/parser_option_view"
  ]
  (
    WellView
    ParserOptionView
  )->
    # パーサーのオプションを管理する
    class ParserOptionsView extends WellView
      # 初期化
      initialize: ->
        @parser_option_views = $ "<div></div>"
        # パーサーの種類が変更されたとき
        @model.on "change:parser", =>
          parser = @model.get "parser"
          @parser_option_views.empty()
          _(parser.get_options()).each (parser_option)=>
            parser_option_view = new ParserOptionView
              model: parser_option
            @parser_option_views.append parser_option_view
        @
      
      # DOMを構築
      render: ->
        @$el
          .empty()
          .append "<p class='bg-info'>parser options</p>"
          .append @parser_option_views
        @

)
