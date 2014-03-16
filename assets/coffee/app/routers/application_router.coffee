define(
  [
    "backbone"
    'jquery'
    "app/models/application_model"
    "app/views/application_view"
  ]
  (
    Backbone
    $
    ApplicationModel
    ApplicationView
  )->
    class ApplicationRouter extends Backbone.Router
      # 初期化
      initialize: ->
        console.log "@ApplicationRouter#initialize"

      # ルーティング
      routes:
        '': 'show_index'

      # 初期画面
      show_index: ->
        console.log "@ApplicationRouter#show_index"

        # ApplicationModelの初期化
        model = new ApplicationModel
          'page.title': 'Graph Visualizer - Home'
          'page.desc': '工事中（under construction）'

        # ApplicationViewの初期化
        view = new ApplicationView
          model: model

        $('body').empty().append view.render().el
)
