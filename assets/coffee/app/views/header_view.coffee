define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    # タイトルなどの管理
    class HeaderView extends Backbone.View
      className: "header container"

      initialize: ->
        @title = $ "<h1></h1>"
        @desc = $ "<p></p>"
        @desc.addClass "lead"
        @update()

        # タイトルが変更されたとき
        @model.on "change", =>
          @update()

      # タイトルや説明を反映する
      # @return [HeaderView] void
      update: ->
        @title.text @model.get "page.title"
        @desc.text @model.get "page.desc"
        @

      # DOMの描画
      render: ->
        @$el.empty()
        @$el.append @title
        @$el.append @desc
        @

)
