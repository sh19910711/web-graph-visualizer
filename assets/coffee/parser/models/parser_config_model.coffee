define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    # パーサーに関する設定を管理するモデル
    # データは内部でJSONの文字列として保持する
    class ParserConfigModel extends Backbone.Model
      urlRoot: "/api/parsers"
      # store[key] = value
      store: {}

      defaults: ->
        # パーサーの種類
        "type": undefined
        # パーサーのオプション
        "options": []

      initialize: ->
        @store = {}

      # keyにvalueを対応付けて保存する
      # @param [String] key
      # @param [Any] value
      # @return [ParserConfigModel] void 
      set_value: (key, value)->
        options = @get "options"
        @store[key] = value
        options.push
          key: key
          value: value
        @

      # 指定されたkeyに関する情報を取り出す
      # @param [String] key
      # @return [Any] keyに対応する情報
      get_value: (key)->
        @store[key]
)
