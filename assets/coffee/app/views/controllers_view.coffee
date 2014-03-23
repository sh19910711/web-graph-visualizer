define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    # textarea
    class TextAreaView extends Backbone.View
      tagName: "textarea"
      className: "form-control"

      initialize: ->
        @$el.css
          maxWidth: "100%"
          width: "100%"
        @

      render: ->
        @

    # 入力欄
    class ControllersTextAreaView extends Backbone.View
      className: "form-group"

      initialize: ->
        @textarea = new TextAreaView
          model: @model
        @textarea.$el.attr "rows", "7"
        @textarea.$el.attr "placeholder", "input text..."
        @textarea.$el.attr "disabled", ""
        @textarea.$el.append "# dummy 20140323\n"
        @textarea.$el.append "5 3\n"
        @textarea.$el.append "1 2\n"
        @textarea.$el.append "2 3\n"
        @textarea.$el.append "4 5\n"
        @

      render: ->
        @$el.empty()
        @$el.append @textarea.render().el
        @

    # 左側
    class ControllersLeftView extends Backbone.View
      initialize: ->
        @textarea = new ControllersTextAreaView
          model: @model

      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">textarea</p>'
        @$el.append @textarea.render().el
        @

    # well
    class WellView extends Backbone.View
      className: "well"

    # オプション
    class ControllersOptionsView extends WellView
      initialize: ->
        @

      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">options</p>'
        @

    # アクション
    class ControllersActionsView extends WellView
      initialize: ->
        @

      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">actions</p>'
        @$el.append '<button disabled class="btn btn-lg btn-primary btn-block">Visualize</button>'
        @$el.append '<button disabled class="btn btn-lg btn-default btn-block">Save as Image</button>'
        @

    # 右側
    class ControllersRightView extends Backbone.View
      initialize: ->
        @options = new ControllersOptionsView
          model: @model
        @actions = new ControllersActionsView
          model: @model

      render: ->
        @$el.empty()
        @$el.append @options.render().el
        @$el.append @actions.render().el
        @

    # 入力などの各種操作を行う
    class ControllersView extends Backbone.View
      className: "controllers container"

      # 初期化
      initialize: ->
        @left = new ControllersLeftView
        @left.$el.addClass "col-sm-6"

        @right = new ControllersRightView
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
