define(
  [
    "backbone"
    "underscore"
  ]
  (
    Backbone
    _
  )->
    # パーサーのインタフェース的なクラス
    class ParserBase extends Backbone.Model
      # 初期化
      initialize: ->

      # 継承先で実装する
      # @param [String] text 解析する文字列
      parse: (text)->
        throw new Error "ERROR_RV7F04: Not Implemented"
)

