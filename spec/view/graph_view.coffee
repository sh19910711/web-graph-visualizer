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
      initialize: (options)->
        # 辺の追加に失敗したとき
        @model.on "error-add-edge", ->
          $('.add_edge.controller .status').empty().append "error-add-edge"

      events:
        # 頂点数を設定する
        "click .set-num-vertices.controller button": ->
          num_vertices = $('.set-num-vertices.controller .input-num-vertices').val()
          @model.init num_vertices
          @$el.append "set num vertices = #{num_vertices}"

        # 辺を追加する
        "click .add_edge.controller button": ->
          from = $('.add_edge.controller .input-from').val()
          to = $('.add_edge.controller .input-to').val()
          @model.add_edge from, to
          @$el.append "from = #{from} / to = #{to}"

      render: ->
        @$el.empty()

        # 頂点数を調整する機能
        set_num_vertices_controller = $('<div class="set-num-vertices controller well row form-horizontal"></div>')
        set_num_vertices_controller.append ->
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
        @$el.append set_num_vertices_controller



        # 辺を追加する機能
        add_edge_controller = $('<div class="add_edge controller well row form-horizontal"></div>')
        add_edge_controller.append ->
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
        @$el.append add_edge_controller

        @

    # デバッガーの初期化
    init = ->
      graph = new GraphModel
      manager_view = new ManagerView
        model: graph

      view = new GraphView
        model: graph
      view.$el.append "test"
      $('#stage').empty().append view.render().el
      $('#controller').empty().append manager_view.render().el

    # entry point
    init()
)
