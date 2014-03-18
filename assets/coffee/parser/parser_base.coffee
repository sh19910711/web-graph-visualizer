define(
  [
    "underscore"
  ]
  (
    _
  )->
    # パーサーのインタフェース的なクラス
    class ParserBase
      # コンストラクタ
      constructor: ->
        # パーサーのデフォルトオプションを設定する
        # 継承先のクラスでObjectかObjectを返す関数を設定する
        if @options instanceof Function
          @__options = @options()
        else if @options instanceof Object
          @__options = _(@options).clone()
        @

      # パーサーのオプション
      __options: {}

      # オプションを設定する
      # @param [String] key オプションを指定するID
      # @param value オプションに設定する値
      set_option: (key, value)->
        @__options[key] = value
        @

      # オプションを取得する
      # @param [String] key オプションを指定するID
      # @return オプションに設定されている値
      get_option: (key)->
        @__options[key]

      # 継承先で実装する
      # @param [String] text 解析する文字列
      parse: (text)->
        throw new Error "ERROR_RV7F04: Not Implemented"
)

