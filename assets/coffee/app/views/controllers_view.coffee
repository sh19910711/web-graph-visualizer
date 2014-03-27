define(
  [
    "backbone"
    "underscore"
    "./controllers/controllers_left_view"
    "./controllers/controllers_right_view"
  ]
  (
    Backbone
    _
    ControllersLeftView
    ControllersRightView
  )->

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
