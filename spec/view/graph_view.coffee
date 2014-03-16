requirejs(
  [
    "graph/models/graph_model"
    "graph/views/graph_view"
    "backbone"
  ]
  (
    GraphModel
    GraphView
    Backbone
  )->
    class ManagerView extends Backbone.View
      # 初期化
      # @param [Object] options 対象のGraphModelなどを渡す
      initialize: (options)->
        #
        # コントローラのDOM
        #

        # 頂点数の設定
        @set_num_vertices_controller = $('<div class="set-num-vertices controller well row form-horizontal"></div>')
        @set_num_vertices_controller.append ->
          res = "<h2>頂点数の設定</h2>"

          res += "<div class=\"status\"></div>"

          res += "<p class=\"col-sm-12\">"
          res += "<label class=\"control-label\">頂点数:</label>"
          res += "<input type=\"text\" class=\"input-num-vertices form-control\">"
          res += "</p>"

          res += "<p class=\"col-sm-12\">"
          res += "<button class=\"btn btn-primary form-control\">Run</button>"
          res += "</p>"
          res

        # 辺を追加
        @add_edge_controller = $('<div class="add_edge controller well row form-horizontal"></div>')
        @add_edge_controller.append ->
          res = "<h2>辺を追加する</h2>"

          res += "<div class=\"status\"></div>"

          res += "<p class=\"col-sm-6\">"
          res += "<label class=\"control-label\">From:</label>"
          res += "<input type=\"text\" class=\"input-from form-control\">"
          res += "</p>"

          res += "<p class=\"col-sm-6\">"
          res += "<label class=\"control-label\">To:</label>"
          res += "<input type=\"text\" class=\"input-to form-control\">"
          res += "</p>"

          res += "<p class=\"col-sm-12\">"
          res += "<button class=\"btn btn-primary form-control\">Run</button>"
          res += "</p>"
          res

        #
        # イベントの処理
        #

        # 辺の追加に失敗したとき
        @model.on "add_edge_error", =>
          @add_edge_controller.find('.status').empty().append "辺の追加に失敗しました"

        # 辺の追加に成功したとき
        @model.on "add_edge_success", =>
          @add_edge_controller.find('.status').empty().append "辺の追加に成功しました"
          # 5秒後に消す
          setTimeout(
            =>
              @add_edge_controller.find('.status').empty()
            5000
          )

      # DOMイベント
      events:
        # 頂点数を設定する
        "click .set-num-vertices.controller button": ->
          num_vertices = @set_num_vertices_controller.find('.input-num-vertices').val()
          @model.init num_vertices

        # 辺を追加する
        "click .add_edge.controller button": ->
          # 頂点番号は整数で指定すること
          from = parseInt @add_edge_controller.find('.input-from').val()
          from = parseInt from, 10
          to = @add_edge_controller.find(' .input-to').val()
          to = parseInt to, 10
          @model.add_edge from, to

      # 描画処理
      render: ->
        @$el.empty()

        # 頂点数を調整する機能
        @$el.append @set_num_vertices_controller

        # 辺を追加する機能
        @$el.append @add_edge_controller

        @

    # デバッガーの初期化関数
    init = ->
      # 描画するGraphModelの準備
      # 5個の頂点と3本の辺を持つ
      graph = new GraphModel
      graph.init 5
      graph.add_edge 0, 1
      graph.add_edge 1, 2
      graph.add_edge 3, 4

      # 実験用の各種操作を行う
      manager_view = new ManagerView
        model: graph

      # GraphModelの画面
      graph_view = new GraphView
        model: graph

      $('#stage').empty().append graph_view.render().el
      $('#controller').empty().append manager_view.render().el

    # entry point
    init()
)
