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
          when "multiselect"
            select_id_list = @get "select_id_list"
            _(select_id_list).map (select_id)=>
              @get("options")[select_id]
          when "flag"
            @get "value"
          when "hidden"
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
          when "select"
            # 検索
            index_of = _(@get "options").indexOf value
            # 存在しないときは例外を投げる
            throw new Error "ERROR_JH5XQ9: Unknown Select Option" if index_of == -1
            # 設定
            @set "select_id", index_of
          when "multiselect"
            # 検索
            index_of = _(@get "options").indexOf value
            # 存在しないときは例外を投げる
            throw new Error "ERROR_AUGM5M: Unknown Multi Select Option" if index_of == -1
            # リストを取得
            select_id_list = @get "select_id_list"

            # 存在するときは削除
            if _(select_id_list).include index_of
              select_id_list = _(select_id_list).reject (select_id)=> select_id == index_of
            # 存在しないときは追加
            else
              select_id_list.push index_of

            @set "select_id_list", select_id_list
          when "flag"
            if arguments.length == 0
              @set "value", !(@get "value")
            else if arguments.length == 1
              @set "value", value
            else
              throw new Error "ERROR_OX1A9Y: Unknown Number of Parameters"
          when "hidden"
            @set "value", "" + value
          else
            throw new Error "ERROR_29LRAC: Unknown Parser Option Type"
        @

      # 初期化
      initialize: ->
        switch @get "type"
          when "text"
            # 値をStringに正規化
            @set "value", "" + @get("value") if @get("value")
          when "select"
            # 1つ以上のオプションが与えられたときは先頭の要素を選択状態にしておく
            @set "select_id", 0 if @get("options").length > 0
          when "multiselect"
            # リストを初期化
            @set "select_id_list", []
          when "flag"
            @set "value", @get("value") || false
          when "hidden"
            # 値をStringに正規化
            @set "value", "" + @get("value") if @get("value")
          else
            throw new Error "ERROR_AT8YQ4: Unknown Parser Option Type"
        @

)
