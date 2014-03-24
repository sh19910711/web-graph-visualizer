define(
  [
    "backbone"
    "underscore"
    "parser/models/parser_option_model"
  ]
  (
    Backbone
    _
    ParserOptionModel
  )->
    # パーサーのインタフェース的なクラス
    class ParserBase extends Backbone.Model
      # 初期化
      # @return [ParserBase] void
      initialize: ->
        @

      # 与えられた文字列を解析して結果を返す（インターフェース）
      # @param [String] text 解析する文字列
      parse: (text)->
        throw new Error "ERROR_RV7F04: Not Implemented"

      # パーサーの名称を取得する（インターフェース）
      # @return [String] パーサーの名称
      get_name: ->
        throw new Error "ERROR_62Q040: Not Implemented"

      # パーサーのサンプル入力を取得する（インターフェース）
      # @return [String] パーサーのサンプル入力
      get_example_input: ->
        throw new Error "ERROR_W76PM2: Not Implemented"

      # 指定したオプションの値を取得する
      # @param [String] key オプションのID
      # @return [Any] オプションの値
      get_option_value: (key)->
        option = @get_option key
        option.get_value()

      # 指定したオプションの値を設定する
      # @param [String] key オプションのID
      # @return [ParserBase] void
      set_option_value: (key, value)->
        option = @get_option key
        option.set_value value
        @

      # 指定したオプションを取得する
      # @param [String] key オプションのID
      # @return [ParserOptionModel] 取得されたオプション
      get_option: (key)->
        @get "option/#{key}"

      # すべてのオプションを取得する
      # @return [Array of ParserOptionModel] すべてのオプション
      get_options: ->
        options = []
        keys = _(@attributes).keys()
        _(keys).each (key)->
          options.push @get key if /^option\//.test key
        options
)

