define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    class SelectView extends Backbone.View
      # DOM Events
      events:
        "change select": "change_select"

      # 初期化
      # @return [SelectView] void
      initialize: (options)->
        @select_tag = $('<select class="form-control"></select>')
        @model.on "create", @update_select_tag
        @model.on "change:items", @update_select_tag
        @update_select_tag()
        @

      # select tagを更新する
      # @return [SelectView] void
      update_select_tag: =>
        @select_tag.empty()
        @model.get("items").each (item, key)=>
          @select_tag.append "<option value=\"#{item.id}\">#{item.get("value")}</option>"
        selected_id = @model.get "selected_id"
        if selected_id
          @select_tag.val(selected_id).trigger("change") unless @select_tag.val() == selected_id
        else
          # 存在しないときは先頭の要素
          @select_tag.val(@select_tag.find("option").first().val()).trigger("change")
        @

      # アイテムが選択されたとき
      # @return [SelectView] void
      change_select: =>
        @model.set "selected_id", @select_tag.val()
        @

      # DOMの描画
      # @return [SelectView] void
      render: ->
        @$el.empty()
        @$el.append @select_tag
        @
)

