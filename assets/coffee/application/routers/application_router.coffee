define(
  [
    "backbone"
    "jquery"
    "application/models/application_model"
    "application/views/layouts/basic_layout_view"
    "application/views/screens/first_screen_view"
    "application/views/screens/second_screen_view"
  ]
  (
    Backbone
    $
    ApplicationModel
    BasicLayoutView
    FirstScreenView
    SecondScreenView
  )->
    class ApplicationRouter extends Backbone.Router
      # 初期化
      initialize: ->
        @application_model = new ApplicationModel
          "page/title": "Graph Visualizer - Graph"
          "page/desc": "工事中 - Under Construction"

        # 基本レイアウト
        @layout_view = new BasicLayoutView
          model: @application_model
          router: @
        $("body").empty().append @layout_view.render().el

      # ルーティング
      routes:
        # http://host/
        "": "show_first_view"

        # http://host/graphs/:graph_id
        "graphs/:graph_id": "show_second_view"

      # グラフを描画する画面
      show_second_view: (graph_id)->
        console.log "@show_second_view"
        @application_model.set "graph_id", graph_id

        view = new SecondScreenView
          model: @application_model
          router: @

        $("#main")
          .empty()
          .append view.render().el

        # IDに対応するグラフを取得させる
        @application_model.fetch_graph graph_id

      # 初期画面
      show_first_view: ->
        console.log "@show_first_view"
        view = new FirstScreenView
          model: @application_model
          router: @

        $("#main")
          .empty()
          .append view.render().el
)
