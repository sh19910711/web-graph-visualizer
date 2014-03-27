define(
  [
    "backbone"
    "underscore"
    "misc/views/select_view"
    "parser/views/parser_option_view"
    "./controllers/controllers_left_view"
  ]
  (
    Backbone
    _
    SelectView
    ParserOptionView
    ControllersLeftView
  )->

    # well
    class WellView extends Backbone.View
      className: "well"

    # パーサーの選択
    class ControllersParserSelectView extends WellView
      initialize: ->
        @parser_select_view = new SelectView
          model: @model.get "parser_select"
        @update()
        @model.on "change:parsers", =>
          @update()
        @

      update: ->
        parsers = @model.get "parsers"
        parser_select = @model.get "parser_select"
        parser_keys = _(parsers).keys()
        items = parser_select.get("items")
        _(parser_keys).each (parser_key)=>
          items.add
            id: parser_key
            value: parser_key

      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">parsers</p>'
        @$el.append @parser_select_view.render().el
        @

    # オプション
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
        @$el.append '<p class="bg-info">options</p>'
        @$el.append @parser_options
        @

    # アクション
    class ControllersActionsView extends WellView
      initialize: ->
        @

      # DOMイベント
      events:
        'click .action-btn[data-action="run-visualize"]': "visualize"

      # 視覚化
      visualize: =>
        parser = @model.get "parser"
        input_text = @model.get("input_text") || ""

        # parse()を実行して得られたグラフをモデルに送信
        graph = parser.parse input_text
        @model.set "graph", graph

      # DOMの描画
      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">actions</p>'
        @$el.append '<button data-action="run-visualize" class="action-btn btn btn-lg btn-primary btn-block">Visualize</button>'
        @$el.append '<button disabled class="action-btn btn btn-lg btn-default btn-block">Save as Image</button>'
        @

    # 右側
    class ControllersRightView extends Backbone.View
      initialize: ->
        @parser_select = new ControllersParserSelectView
          model: @model
        @options = new ControllersOptionsView
          model: @model
        @actions = new ControllersActionsView
          model: @model

      render: ->
        @$el.empty()
        @$el.append @parser_select.render().el
        @$el.append @options.render().el
        @$el.append @actions.render().el
        @

    # 入力などの各種操作を行う
    class ControllersView extends Backbone.View
      className: "controllers container"

      # 初期化
      initialize: ->
        @left = new ControllersLeftView
          model: @model
        @left.$el.addClass "col-sm-6"

        @right = new ControllersRightView
          model: @model
        @right.$el.addClass "col-sm-6"

      # DOMの描画
      render: ->
        @$el.empty()
        @$el.append '<div class="row"></div>'
        row = @$el.children('.row')
        row.append @left.render().el
        row.append @right.render().el
        @$el.append row
        @
)
