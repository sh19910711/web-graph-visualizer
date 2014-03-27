define(
  [
    "backbone"
    "./controllers_parser_select_view"
    "./controllers_options_view"
    "./controllers_actions_view"
  ]
  (
    Backbone
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
)
