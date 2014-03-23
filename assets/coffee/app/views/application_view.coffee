define(
  [
    "backbone"
    "jquery"
    "app/views/header_view"
    "app/views/contents_view"
  ]
  (
    Backbone
    $
    HeaderView
    ContentsView
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
        @controllers = $('<div id="controllers" class="container"></div>')

        left = $('<div class="col-sm-6"></div>')
        left.append '<p class="bg-info">textarea</p>'
        textarea = $('<textarea disabled class="form-control" placeholder="input text..." rows="7"></textarea>')
        textarea.append "# dummy\n"
        textarea.append "5 3\n"
        textarea.append "1 2\n"
        textarea.append "2 3\n"
        textarea.append "4 5\n"
        left.append textarea

        right = $('<div class="col-sm-6"></div>')
        well = $('<div class="well"></div>')
        well.append '<p class="bg-info">options</p>'
        well.append '<p class="bg-info">actions</p>'
        well.append '<button disabled class="btn btn-lg btn-primary btn-block">Visualize</button>'
        well.append '<button disabled class="btn btn-lg btn-default btn-block">Save as Image</button>'
        right.append well

        row = $('<div class="row"></div>')
        row.append left
        row.append right
        @controllers.append row

        @

      # 描画
      render: ->
        @$el.empty()
        @$el.append @header_view.render().el
        @$el.append @contents_view.render().el
        @$el.append @controllers
        @

)
