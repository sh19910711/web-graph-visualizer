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
        @get "value"

      # 値を設定する
      # valueに対して値を設定
      # @param [Any] 設定する値
      # @return [ParserOptionModel] void
      set_value: (value)->
        switch @get "type"
          when "text"
            @set "value", "" + value

          when "select"
            if value
              # 検索
              index_of = _(@get "options").indexOf value

              # 存在しないときは例外を投げる
              throw new Error "ERROR_JH5XQ9: Unknown Select Option: #{value}" if index_of == -1

              # 設定
              @set "select_id", index_of

              # set value
              select_id = @get "select_id"
              @set "value", @get("options")[select_id]

          when "multiselect"
            select_id_list = []
            if value
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

            # set value
            select_id_list = @get "select_id_list"
            @set "value", _(select_id_list).map (select_id)=>
              @get("options")[select_id]

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
            @set_select_options @get("options")
          when "multiselect"
            # リストを初期化
            @set "select_id_list", []
            @set "value", []
          when "flag"
            unless !! @get("name")
              throw new Error "ERROR_ZS4PMC: name property must be specified" 
            @set "value", @get("value") || false
          when "hidden"
            # 値をStringに正規化
            @set "value", "" + @get("value") if @get("value")
          else
            throw new Error "ERROR_AT8YQ4: Unknown Parser Option Type"
        @

      # type=select/multiselectで使うオプションを追加する
      # @param [String] option 追加するオプション
      add_option: (option)->
        options = _.clone(@get("options")) || []
        # 存在しないときに追加する
        unless _(options).include option
          options.push option 
          @set "options", options
          # type=selectで新しく要素が追加されたときはその要素を選択状態にしておく
          if @get("type") == "select" && options.length == 1
            @set_value option

      # type=select/multiselectで使うオプションを設定する
      # @param [Array] options 指定するオプション
      set_select_options: (options)->
        # optionsが未定義の場合は空の配列で初期化
        @set "options", options || []
        # 1つ以上のオプションが与えられたときは先頭の要素を選択状態にしておく
        if @get("options").length > 0
          select_id = 0
          @set "select_id", select_id
          @set "value", @get("options")[select_id]


)
