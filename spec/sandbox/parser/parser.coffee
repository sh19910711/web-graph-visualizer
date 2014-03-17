requirejs(
  [
    "jquery"
    "backbone"
    "underscore"
    "graph/models/graph_model"
    # ここから下側にParserクラスを記述する
    "parser/graph/graph_parser_example"
  ]
  (
    $
    Backbone
    _
    GraphModel
    # Parserクラスは記述しないようにする
  )->
    # 読み込まれたParserクラスを取り出す
    parser_class_hash = {}
    parser_classes = _(arguments).toArray().slice(4)
    _(parser_classes).each (parser_class)->
      parser_class_hash[parser_class.name] = parser_class
      
    
    class Model extends Backbone.Model
      # 初期値
      defaults: ->
        text: ""
        result: undefined
        
    class InputView extends Backbone.View
      # 初期化
      initialize: ->
        @textarea = $('<textarea class="form-control" rows="8"></textarea>')
        @
        
      get_textarea: ->
        @textarea
        
      # 描画
      render: ->
        @$el
          .empty()
          .append '<h2>Input</h2>'
          .append @textarea
        @
        
    class ResultView extends Backbone.View
      # 初期化
      initialize: ->
        @textarea = $('<textarea disabled class="form-control" rows="8">ここに結果が出力されます</textarea>')
        
        # 結果が変更されたとき
        @model.on "change:result", =>
          @textarea
            .empty()
            .append =>
              res = ""
              
              # 入力文字列
              res += "## 入力\n"
              res += @model.get("text")
              res += "\n"
              
              result = @model.get("result")
              if result instanceof GraphModel
                graph = result
                
                # 出力されたグラフに関する情報を出力する
                n = graph.get_num_vertices()
                res += "## 出力\n"
                res += "頂点数: #{n}\n"
                
                # グラフが持つ辺の情報
                for s_id in [0 .. n - 1]
                  for t_id in [0 .. n - 1]
                    if graph.check_edge s_id, t_id
                      res += "辺: #{s_id} - #{t_id}\n"
              else
                res += "ERROR!!\n"
                res += result.toString()
                res += "\n"
              
              res
        @
      
      # 描画
      render: ->
        @$el
          .empty()
          .append '<h2>Result</h2>'
          .append @textarea
        @
    
    # 管理用Viewクラス
    class ManagerView extends Backbone.View
      # 初期化
      initialize: (options)->
        @input_view = options.input_view
        
        @result = $('<div class=""></div>')
        @actions = $('<div class="well"></div>')
        @actions.append ->
          res = ''
          res += '<h3>Parserクラスを選択</h3>'
          res += '<p>'
          res += '<select id="parser-type" class="form-control">'
          for key in _(parser_class_hash).keys()
            res += "<option data-parser-type=\"#{key}\">#{key}</option>"
          res += '</select>'
          res += '</p>'
          res
        @actions.append "<h3>実行するメソッド</h3>"
        @actions.append '<p><button class="run-parse btn btn-primary btn-large">parse()</button></p>'
        @
        
      # DOMイベント
      events:
        "click button.run-parse": "run_parse"
      
      # parseメソッドを実行する
      run_parse: ->
        parser_type = $('#parser-type option:selected').data('parser-type')
        parser = new parser_class_hash[parser_type]
        input_text = @input_view.get_textarea().val()
        @model.set "text", input_text
        try
          parsed_graph = parser.parse input_text
          @model.set "result", parsed_graph
        catch error
          # 例外が返ってきたとき
          @model.set "result", error
        @
        
      # 描画
      render: ->
        @$el
          .empty()
          .append @actions
        @
    
    # 初期化
    init = ->
      # 入力文字列
      model = new Model
      
      # 結果出力用のView
      result_view = new ResultView
        model: model
      
      # 入力文字列のView
      input_view = new InputView
        model: model
      
      # 各種操作を行うView
      manager_view = new ManagerView
        model: model
        input_view: input_view
        
      $('#stage').append input_view.render().el
      $('#stage').append result_view.render().el
      $("#controller").append manager_view.render().el
      
    # entry point
    init()
)