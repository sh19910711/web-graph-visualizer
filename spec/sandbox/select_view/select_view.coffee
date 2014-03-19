requirejs(
  [
    "misc/models/select_model"
    "misc/views/select_view"
    "backbone"
    "jquery"
  ]
  (
    SelectModel
    SelectView
    Backbone
    $
  )->
    class CheckerView extends Backbone.View
      initialize: ->
        @selected_key = $("<span></span>")
        @model.on "create", @update_selected_key
        @model.on "change:selected_key", @update_selected_key
        @update_selected_key()

      update_selected_key: =>
        items = @model.get "items"
        key = @model.get "selected_key"
        console.log @selected_key
        @selected_key.empty().append items[key]

      render: ->
        @$el.empty()
        @$el.append "Selected Key: "
        @$el.append @selected_key
        @

    # 初期化
    init = ->
      model = new SelectModel
        items: [
          "test 1"
          "test 2"
          "test 3"
          "test 4"
          "test 5"
        ]
        selected_key: 0
      view = new SelectView
        model: model
      checker_view = new CheckerView
        model: model
      $("#stage")
        .empty()
        .append checker_view.render().el
      $("#controller")
        .empty()
        .append view.render().el

    # entry point
    init()
)
