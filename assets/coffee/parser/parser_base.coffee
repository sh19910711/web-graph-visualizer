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
        else
          @__options = _(@options).clone()

      # パーサーのオプション
      __options: {}

      # オプションを設定する
      set_option: (key, value)->
        @__options[key] = value

      # オプションを取得する
      get_option: (key)->
        @__options[key]

      # 継承先で実装する
      # @param [String] text 解析する文字列
      parse: (text)->
        throw new Error "ERROR_RV7F04: TODO: Implement"
)

