define(
  [
    "backbone"
    "jquery"
  ]
  (
    Backbone
    $
  )->
    class LayoutView extends Backbone.View
      className: "container"

      # DOMの構築
      render: ->
        @$el
          .empty()
          # 上部
          .append =>
            row = $("<div></div>")
            row
              .addClass "container"
              .append $ '<h1 class="page_title">' + @model.get("page/title") + '</h1>'
              .append $ '<p class="page_desc lead">' + @model.get("page/desc") + '</p>'
          # メインコンテンツ
          .append =>
            row = $("<div></div>")
            row
              .addClass "container"
              .prop "id", "main"
        @

)
