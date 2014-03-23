define(
  [
    "backbone"
    "jquery"
    "app/views/header_view"
    "app/views/contents_view"
    "app/views/controllers_view"
  ]
  (
    Backbone
    $
    HeaderView
    ContentsView
    ControllersView
  )->
    class ApplicationView extends Backbone.View
      tagName: "div"
      className: "view"

      # 初期化
      initialize: ->
        console.log "@ApplicationView#initialize"

        #
        # DOMの初期化
        #

        # ヘッダ
        @header_view = new HeaderView
          model: @model

        # Graph View
        @contents_view = new ContentsView
          model: @model

        # 各種操作用
        @controllers_view = new ControllersView
          model: @model

        @

      # 描画
      render: ->
        @$el.empty()
        @$el.append @header_view.render().el
        @$el.append @contents_view.render().el
        @$el.append @controllers_view.render().el
        @

)
