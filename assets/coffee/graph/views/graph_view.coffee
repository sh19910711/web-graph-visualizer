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

        @links = [
          {source: 0, target: 1}
          {source: 1, target: 2}
        ]

        # svg要素
        @svg = d3
          .select @visualizer[0]
          .append 'svg'
          .attr 'width', DEFAULT_WIDTH
          .attr 'height', DEFAULT_HEIGHT

        # 何か力学的なものを働かせる
        @force = d3.layout
          .force()
          .nodes(@nodes)
          .links(@links)
          .size [DEFAULT_WIDTH, DEFAULT_HEIGHT]
          .linkDistance 100
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
          .selectAll 'circle'
          .data @nodes

        @node
          .enter()
          .append 'circle'
          .style 'fill', '#FFFFFF'
          .style 'stroke', '#FF9999'
          .style 'stroke-width', '3px'
          .attr 'r', 16
          .attr 'cx', "#{DEFAULT_WIDTH / 2}px"
          .attr 'cy', "#{DEFAULT_HEIGHT / 2}px"
          .call @force.drag

        @node
          .exit()
          .remove()

        # 渡す関数は=>でbindする
        @force.on 'tick', =>
          @link
            .attr 'x1', (d)-> d.source.x
            .attr 'y1', (d)-> d.source.y
            .attr 'x2', (d)-> d.target.x
            .attr 'y2', (d)-> d.target.y
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
