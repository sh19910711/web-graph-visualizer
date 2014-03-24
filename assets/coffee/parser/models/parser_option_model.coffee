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
          when "select"
            select_id = @get "select_id"
            @get("options")[select_id]
          else
            throw new Error "ERROR_SGRVQ6: Unknown Parser Option Type"

      # 値を設定する
      # @param [Any] 設定する値
      # @return [ParserOptionModel] void
      set_value: (value)->
        switch @get "type"
          when "text"
            @set "value", "" + value
          when "select"
            index_of = _(@get "options").indexOf value
            throw new Error "ERROR_JH5XQ9: Unknown Select Option" if index_of == -1
            @set "select_id", index_of
          else
            throw new Error "ERROR_29LRAC: Unknown Parser Option Type"
        @

      # 初期化
      initialize: ->
        switch @get "type"
          when "text"
            # 値をStringに正規化
            @set "value", "" + @get("value")
          when "select"
            # 1つ以上のオプションが与えられたときは先頭の要素を選択状態にしておく
            @set "select_id", 0 if @get("options").length > 0
        @

)
