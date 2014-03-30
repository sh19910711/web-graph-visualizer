define(
  [
    "parser/views/parser_option_view"
    "./well_view"
  ]
  (
    ParserOptionView
    WellView
  )->
    # パーサーのオプション
    class ControllersOptionsView extends WellView
      initialize: ->
        @parser_options = $ '<div></div>'
        # パーサーの種類が変更されたとき
        @model.on "change:parser", =>
          parser = @model.get "parser"
          # オプションのリストを更新する
          @parser_options.empty()
          _(parser.get_options()).each (parser_option)=>
            parser_option_view = new ParserOptionView
              model: parser_option
            @parser_options.append parser_option_view.render().el
        @

      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">parser options</p>'
        @$el.append @parser_options
        @
)
