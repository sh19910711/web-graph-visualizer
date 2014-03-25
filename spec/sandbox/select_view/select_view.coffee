requirejs(
  [
    "misc/models/select_model"
    "misc/views/select_view"
    "misc/models/item_model"
    "misc/collections/item_collection"
    "backbone"
    "jquery"
  ]
  (
    SelectModel
    SelectView
    ItemModel
    ItemCollection
    Backbone
    $
  )->
    class CheckerView extends Backbone.View
      initialize: ->
        @selected_id = $("<span></span>")
        @model.on "create", @update_selected_id
        @model.on "change:selected_id", @update_selected_id
        @update_selected_id()

      update_selected_id: =>
        items = @model.get "items"
        key = @model.get "selected_id"
        @selected_id.empty().append items.get(key).get("value")

      render: ->
        @$el.empty()
        @$el.append "Selected ID: "
        @$el.append @selected_id
        @

    # 初期化
    init = ->
      model = new SelectModel
        items: new ItemCollection(
          [
            new ItemModel
              id: "test-1"
              value: "test 1"
            new ItemModel
              id: "test-2"
              value: "test 2"
            new ItemModel
              id: "test-3"
              value: "test 3"
            new ItemModel
              id: "test-4"
              value: "test 4"
            new ItemModel
              id: "test-5"
              value: "test 5"
          ]
        )
        selected_id: "test-1"
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
