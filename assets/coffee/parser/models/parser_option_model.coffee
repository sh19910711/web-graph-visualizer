define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    # パーサーのオプションを管理するクラス
    class ParserOptionModel extends Backbone.Model
      defaults: ->
        type: undefined

      # 値を取得する
      # @return [Any] オプションの値
      get_value: ->
        switch @get "type"
          when "text"
            @get "value"
          else
            throw new Error "ERROR_SGRVQ6: Unknown Parser Option Type"

      # 値を設定する
      # @param [Any] 設定する値
      # @return [ParserOptionModel] void
      set_value: (value)->
        switch @get "type"
          when "text"
            @set "value", "" + value
          else
            throw new Error "ERROR_29LRAC: Unknown Parser Option Type"
        @

      # 初期化
      initialize: ->
        # 値をStringに正規化
        switch @get "type"
          when "text"
            @set "value", "" + @get("value")
        @

)
