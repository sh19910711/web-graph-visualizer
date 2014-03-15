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
      initialize: ->
        @
        
      # 初期化
      # @param [Number] num_vertices 頂点数を指定する
      init: (num_vertices)->
        @set "num_vertices", num_vertices
        adj_list = new Array num_vertices
        for i in [0 .. num_vertices - 1]
          adj_list[i] = []
        @set "adj_list", adj_list
        @
          
      # 頂点数を返す
      get_num_vertices: ->
        @get "num_vertices"
        
      # 辺の本数を返す
      get_num_edges: ->
        @get "num_edges"
        
      # 辺を追加する
      # @param [Number] from 始点
      # @param [Number] to 終点
      add_edge: (from, to)->
        # 辺が存在するときは何もしない
        return @ if @check_edge from, to
        num_edges = @get "num_edges"
        @set "num_edges", num_edges + 1
        
        # 辺を追加する
        adj_list = @get "adj_list"
        adj_list[from].push to
        @set "adj_list", adj_list
        
        @
        
      # 辺を削除する
      # @param [Number] from 始点
      # @param [Number] to 終点
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
        _(@get("adj_list")[from]).indexOf(to) != -1

)
