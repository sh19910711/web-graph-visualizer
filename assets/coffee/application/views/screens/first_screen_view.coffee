define(
  [
    "backbone"
    "jquery"
    "application/views/components/input_text_view"
    "application/views/components/parser_select_view"
    "application/views/components/parser_options_view"
    "application/views/components/actions_view"
  ]
  (
    Backbone
    $
    InputTextView
    ParserSelectView
    ParserOptionsView
    ActionsView
  )->
    # 初期画面: http://host/
    class FirstView extends Backbone.View
      className: "view"

      # 初期化 
      initialize: (options)->
        # options
        @router = options.router

        #
        # Child Views
        #

        # 入力欄
        @textarea = new InputTextView
          model: @model

        # パーサーの種類選択
        @parser_select = new ParserSelectView
          model: @model

        # パーサーのオプションを選択
        @parser_options = new ParserOptionsView
          model: @model

        # 各種処理の実行
        @actions = new ActionsView
          model: @model

      # DOM イベント
      events:
        'click .action-btn[data-action="run-visualize"]': "visualize"

      # 視覚化を実行する　
      visualize: =>
        @model.save_graph().done (graph_id)=>
          @router.navigate "/graphs/#{graph_id}", {trigger: true}

      # DOMの構築
      render: ->
        @$el
          .empty()
          .append =>
            row = $("<div></div>")
            row.addClass "row"

            # 一列目
            # グラフを表す文字列の入力
            row.append =>
              col = $("<div></div>")
              col.addClass "col-sm-6"
              col.append @textarea.render().el

            # 二列目
            # 1. パーサーの選択
            # 2. パーサーのオプションを選択
            # 3. 各種操作
            row.append =>
              col = $("<div></div>")
              col.addClass "col-sm-6"
              col.append @parser_select.render().el
              col.append @parser_options.render().el
              col.append @actions.render().el

            row
        @

)
