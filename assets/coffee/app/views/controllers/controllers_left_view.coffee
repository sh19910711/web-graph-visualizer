define(
  [
    "backbone"
    "./controllers_text_area_view"
  ]
  (
    Backbone
    ControllersTextAreaView
  )->
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
)
