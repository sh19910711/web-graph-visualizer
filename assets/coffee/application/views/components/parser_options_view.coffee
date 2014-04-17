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
        @parser_option_views = []
        @update_parser_options()

        #
        # モデルのイベントを監視する
        #

        # パーサーの種類が変更されたとき
        @model.on "change:parser", =>
          # 更新してDOMを再構築
          @update_parser_options()
          @render()
        @

      # パーサーのオプション一覧を更新する
      update_parser_options: ->
        # パーサーを取得
        parser = @model.get "parser"

        # パーサーがインスタンス化されていないときは何もしない
        return @ unless parser

        # オプション一覧の更新
        @parser_option_views = []
        parser_options = parser.get_options()
        _(parser_options).each (parser_option)=>
          parser_option_view = new ParserOptionView
            model: parser_option
          @parser_option_views.push parser_option_view
      
      # DOMを構築
      render: ->
        @$el
          .empty()
          .append "<p class='bg-info'>parser options</p>"
        _(@parser_option_views).each (parser_option_view)=>
          @$el.append parser_option_view.render().el
        @

)
