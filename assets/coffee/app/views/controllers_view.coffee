define(
  [
    "backbone"
    "underscore"
    "./controllers/controllers_left_view"
    "./controllers/controllers_parser_select_view"
    "./controllers/controllers_options_view"
    "./controllers/controllers_actions_view"
  ]
  (
    Backbone
    _
    ControllersLeftView
    ControllersParserSelectView
    ControllersOptionsView
    ControllersActionsView
  )->
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
