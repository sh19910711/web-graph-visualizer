define(
  [
    "backbone"
    "underscore"
    "graph/models/graph_model"
    "app/models/input_text_model"
    "parser/models/parser_config_model"
  ]
  (
    Backbone
    _
    GraphModel
    InputTextModel
    ParserConfigModel
  )->
    # アプリケーションに関する情報を管理するクラス
    class ApplicationModel extends Backbone.Model
      # 初期値の設定
      defaults: ->
        # 描画するグラフ（GraphModel）
        graph: undefined
        
        # 入力文字列を管理する
        input_text: undefined

        # 選択されているパーサーをインスタンス化したもの（ParserBase）
        parser: undefined

        # インスタンス化されているパーサーのオプションを管理する
        parser_config: undefined

        # 有効なパーサークラスの集合
        parsers: {}

        # 有効なパーサークラスのキー一覧
        parser_keys: []

        # 選択されているパーサー
        selected_parser: undefined

      # 初期化
      initialize: ->
        # GraphModelの初期化
        graph = new GraphModel
        graph.init 0
        @set "graph", graph

        # InputTextの初期化
        input_text = new InputTextModel
          id: "dummy"
        @set "input_text", input_text

        # ParserConfigModelの初期化
        parser_config_model = new ParserConfigModel
          id: "dummy"
        @set "parser_config", parser_config_model

        # パーサーの読み込み
        @fetch_all_parsers().done =>
          # とりあえずインスタンスをつくっておく  　
          @touch_parser()

        #
        # 自身の状態を監視する　
        #
        
        # 選択されているパーサーが変更されたとき
        @on "change:selected_parser", =>
          parsers = @get "parsers"
          selected_parser = @get "selected_parser"
          @set "parser", new parsers[selected_parser]
            config: @get "parser_config"

        @

      # parserが未定義の場合はparsersの先頭の要素でインスタンスをつくる
      touch_parser: ->
        parsers = @get "parsers"
        # parserが未定義の場合
        unless @get "parser"
          if @get "selected_parser"
            # selected_parserが指定してあるときはそのパーサーでインスタンス生成
            selected_parser = @get "selected_parser"
            @set "parser", new parsers[selected_parser]
          else if _(parsers).keys().length > 0
            # parsersの先頭の要素で初期化しておく
            parser_keys = @get "parser_keys"
            @set "parser", new parsers[parser_keys[0]]
            @set "selected_parser", parsers[parser_keys[0]].name

      # すべてのパーサーを読み込む
      # @return [jQuery.Deferred] Deferred Object
      fetch_all_parsers: ->
        deferred = new $.Deferred
        requirejs(
          [
            "parser/graph/graph_parser_example"
            "parser/graph/adjacent_list_parser"
            "parser/graph/adjacent_matrix_parser"
          ]
          =>
            # パーサーの集合をつくる
            parsers = _(arguments).reduce(
              (prev, ParserClass)->
                obj = {}
                obj[ParserClass.name] = ParserClass
                _(prev).extend obj
              {}
            )
            @set "parsers", parsers
            @set "parser_keys", _(parsers).keys()
            deferred.resolve()
        )
        deferred


      # グラフを取得する
      fetch_graph: ()->
        deferred = new $.Deferred
        graph_id = @get "graph_id"

        input_text = @get "input_text"
        input_text.id = graph_id

        parser_config = @get "parser_config"
        parser_config.id = graph_id

        deferreds = []
        deferreds.push input_text.fetch()
        deferreds.push parser_config.fetch()
        $.when.apply(@, deferreds).done =>
          deferred.resolve graph_id

        deferred

      # グラフを保存する
      # 保存に成功したとき deferred.resolve(graph_id) を呼び出す
      # @return [jQuery.Deferred] Deferred Object
      save_graph: ->
        deferred = new $.Deferred

        # グラフIDを申請
        $.ajax(
          type: "post"
          url: "/graphs"
          data: JSON.stringify({})
          contentType: "application/json"
          dataType: "json"
        ).done (res)=>
          graph_id = res.graph_id
          @set "graph_id", graph_id

          input_text = @get("input_text")
          input_text.id = graph_id

          parser_config = @get("parser_config")
          parser_config.id = graph_id

          # 保存する
          deferreds = []
          deferreds.push input_text.save {}
          deferreds.push parser_config.save {}

          # 保存が完了したとき
          $.when.apply(@, deferreds).done =>
            deferred.resolve(graph_id)

        deferred

)
