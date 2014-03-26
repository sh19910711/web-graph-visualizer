define(
  [
    "backbone"
    "d3"
    "jquery"
  ]
  (
    Backbone
    d3
    $
  )->
    DEFAULT_WIDTH  = 640
    DEFAULT_HEIGHT = 480

    # GraphModelのView
    # divタグの中で、svg/canvasタグを操作する
    class GraphView extends Backbone.View
      # HTMLタグ
      tagName: "div"

      # 初期化
      initialize: ->
        #
        # ビジュアライザに関する初期化
        #

        # svg/canvasタグを配置する要素
        @visualizer = $("<div></div>")

        # @nodesのサンプル
        # @nodes = [
        #   {name: "test 1"}
        #   {name: "test 2"}
        #   {name: "test 3"}
        # ]
        @nodes = []
        num_vertices = @model.get_num_vertices()
        for v_id in [0 .. num_vertices - 1]
          @nodes.push
            name: "##{v_id}"

        # @linksのサンプル
        # @links = [
        #   {source: 0, target: 1}
        #   {source: 1, target: 2}
        # ]
        @links = @model.get_edges("source", "target")

        # svg要素
        @svg = d3
          .select @visualizer[0]
          .append 'svg'
          .attr 'style', "width: 100%; height: #{DEFAULT_HEIGHT}px;"

        # 何か力学的なものを働かせる
        @force = d3.layout
          .force()
          .nodes(@nodes)
          .links(@links)
          .size [DEFAULT_WIDTH, DEFAULT_HEIGHT]
          .linkDistance 100
          .chargeDistance 100
          .start()

        # 更新
        @update_visualizer()

        # 位置の更新, 渡す関数は=>でbindする
        @force.on 'tick', @tick_visualizer

        #
        # イベントの処理
        #

        # 頂点数が変更されたとき
        @model.on "change:num_vertices", =>
          # 再構築
          num_vertices = @model.get_num_vertices()
          @nodes = []
          for v_id in [0 .. num_vertices - 1]
            @nodes.push
              name: "##{v_id}"

          @links = @model.get_edges("source", "target")

          # DOMを更新する
          @update_visualizer()

        # 辺が追加されたとき
        @model.on "add_edge_success", =>
          # 再構築
          num_vertices = @model.get_num_vertices()
          @nodes = []
          for v_id in [0 .. num_vertices - 1]
            @nodes.push
              name: "##{v_id}"

          @links = @model.get_edges("source", "target")

          # DOMを更新する
          @update_visualizer()

        @

      # 位置などの更新
      tick_visualizer: =>
        @link
          .attr 'x1', (d)-> d.source.x
          .attr 'y1', (d)-> d.source.y
          .attr 'x2', (d)-> d.target.x
          .attr 'y2', (d)-> d.target.y
        @node
          .attr 'x', (d)-> d.x
          .attr 'y', (d)-> d.y
          .attr "transform", (d)-> "translate(#{d.x},#{d.y})"
        @

      # ビジュアライザに関するDOMの更新
      update_visualizer: ->
        @force
          .nodes(@nodes)
          .links(@links)
          .start()

        @link = @svg
          .selectAll 'line'
          .data @links, (d)-> d.target.name

        @link
          .enter()
          .insert 'line', 'circle'
          .style 'stroke', '#999999'
          .style 'stroke-width', '2px'
          .attr 'x1', (d)-> d.source.x
          .attr 'y1', (d)-> d.source.y
          .attr 'x2', (d)-> d.target.x
          .attr 'y2', (d)-> d.target.y

        @link
          .exit()
          .remove()

        @node = @svg
          .selectAll '.node'
          .data @nodes

        # .node
        node_groups = @node
          .enter()
          .append 'g'
          .attr 'class', 'node'
          .attr 'x', "#{DEFAULT_WIDTH/2}px"
          .call @force.drag

        # .node circle
        node_groups
          .append 'circle'
          .style 'fill', '#FFFFFF'
          .style 'stroke', '#FF9999'
          .style 'stroke-width', '3px'
          .attr 'r', 16

        # .node text
        node_groups
          .append 'text'
          .attr 'dx', '-8px'
          .attr 'dy', '6px'
          .text (d)-> d.name

        @node
          .exit()
          .remove()

        @

      # 描画
      render: ->
        @$el.empty()
        @$el.append @visualizer

        @
)
