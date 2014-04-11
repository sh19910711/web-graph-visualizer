define(
  [
    "backbone"
    "underscore"
    "jquery"
  ]
  (
    Backbone
    _
    $
  )->
    # select tagを管理するクラス
    # DOMの変更に合わせて指定したモデルの値を変化させる
    class SelectTagView extends Backbone.View
      # 初期化
      initialize: (options)->
        # selectタグの状態変化に対応して変化するモデルのプロパティ
        @key = options.key
        # optionタグに落とし込む値の集合
        @items_key = options.items_key

        @select_tag = $ "<select></select>"
        @select_tag.addClass "form-control"

        @update_select_items()

        #
        # モデルの状態を監視する
        #

        # model.items_keyに変更があったらselect tagに反映する
        @model.on "change:#{@items_key}", =>
          @update_select_items()

        # model.keyが別の値に変化したら、select tagも変化させる
        @model.on "change:#{@key}", =>
          dom_value = @select_tag.val()
          model_value = @model.get @key
          @select_tag.val model_value if dom_value != model_value

      # DOMイベント
      events:
        "change select": "change_select_tag"

      # select tagに変更があるとき
      change_select_tag: =>
        # model.keyも変化させる
        dom_value = @select_tag.val()
        model_value = @model.get @key
        console.log "change select tag"
        @model.set @key, dom_value if model_value != dom_value

      # select tagを作り直す
      update_select_items: ->
        @select_tag.empty()
        items = @model.get @items_key
        _(items).each (item)=>
          @select_tag.append $ '<option value="' + item + '">' + item + '</option>'

      # DOMの構築
      render: ->
        @$el
          .empty()
          .append @select_tag
        @
)
