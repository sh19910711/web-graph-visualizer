define(
  [
    "backbone"
    "underscore"
  ]
  (
    Backbone
    _
  )->
    # 有向グラフを表すクラス
    class GraphModel extends Backbone.Model
      # 初期値の設定
      defaults: ->
        {
          num_vertices: 0
          num_edges: 0
          adj_list: []
        }
        
      # 初期化関数
      # newされたときに呼ばれるメソッド
      # @return [GraphModel] void
      initialize: ->
        if @get "num_vertices"
          @init(@get "num_vertices")

        if @get "edges"
          _(@get "edges").each((edge) => @add_edge(edge.from, edge.to))

        @
        
      # 初期化
      # @param [Number] num_vertices 頂点数を指定する
      # @return [GraphModel] void
      init: (num_vertices)->
        @set "num_vertices", num_vertices
        adj_list = new Array num_vertices
        for i in [0 .. num_vertices - 1]
          adj_list[i] = []
        @set "adj_list", adj_list
        @
          
      # 頂点数を返す
      # @return [Number] 頂点数
      get_num_vertices: ->
        @get "num_vertices"
        
      # 辺の本数を返す
      # @return [Number] 辺の本数
      get_num_edges: ->
        @get "num_edges"
        
      # 辺を追加する
      # @param [Number] from 始点
      # @param [Number] to 終点
      # @return [GraphModel] void
      add_edge: (from, to)->
        # 辺が存在するときは何もしない
        return @ if @check_edge from, to
        num_edges = @get "num_edges"
        @set "num_edges", num_edges + 1
        
        # 辺を追加する
        adj_list = @get "adj_list"
        adj_list[from].push to
        @set "adj_list", adj_list
        @trigger "add_edge_success"
        
        @
        
      # 辺を削除する
      # @param [Number] from 始点
      # @param [Number] to 終点
      # @return [GraphModel] void
      remove_edge: (from, to)->
        # 辺が存在しないときは何もしない
        return @ unless @check_edge from, to
        
        # 辺の本数を減らす
        num_edges = @get "num_edges"
        @set "num_edges", num_edges - 1
        
        # 辺の削除
        adj_list = @get "adj_list"
        adj_list[from] = _.reject adj_list[from], (ind)->
          # indがtoと等しければ削除する
          ind == to
        @set "adj_list", adj_list
        
        @
        
      # 辺が存在するかどうか確認する
      # @param [Number] from 始点
      # @param [Number] to 終点
      # @return [Boolean] 辺が存在するときにtrueを返す
      check_edge: (from, to)->
        # 辺が存在するかどうか調べる
        _(@get("adj_list")[from]).include(to)

      # D3.jsで利用できる形式で、辺のリストを取得する
      # @param [String] from_key 始点を表すキー
      # @param [String] to_key 終点を表すキー
      # @return [Array] 辺のリスト
      get_edges: (from_key, to_key)->
        links = []

        for from_id in _.range(@get "num_vertices")
          for to_id in @get("adj_list")[from_id]
            tmp = {}
            tmp[from_key] = from_id
            tmp[to_key] = to_id
            links.push tmp

        links
)
