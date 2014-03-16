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
      # タグ
      tagName: "div"

      # 初期化
      initialize: ->
        # svg/canvasタグを配置する要素
        @visualizer = $("<div></div>")

        @nodes = [
          {name: "test 1"}
          {name: "test 2"}
          {name: "test 3"}
        ]

        @svg = d3
          .select @visualizer[0]
          .append 'svg'
          .attr 'width', DEFAULT_WIDTH
          .attr 'height', DEFAULT_HEIGHT

        @force = d3.layout
          .force()
          .nodes(@nodes)
          .size [DEFAULT_WIDTH, DEFAULT_HEIGHT]
          .linkDistance 100
          .start()

        @node = @svg
          .selectAll 'circle'
          .data @nodes
          .enter()
          .append 'circle'
          .style 'fill', '#FFFFFF'
          .style 'stroke', '#FF9999'
          .style 'stroke-width', '3px'
          .attr 'r', 16
          .attr 'cx', "#{DEFAULT_WIDTH / 2}px"
          .attr 'cy', "#{DEFAULT_HEIGHT / 2}px"
          .call @force.drag

        # 渡す関数は=>でbindする
        @force.on 'tick', =>
          @node
            .attr 'cx', (d)-> d.x
            .attr 'cy', (d)-> d.y

        @

      tick_visualizer: ->
        @

      update_visualizer: ->
        @

      # 描画
      render: ->
        @$el.empty()
        @$el.append "graph view"
        @$el.append @visualizer

        @
)
