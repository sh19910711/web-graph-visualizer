define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    class SelectView extends Backbone.View
      # <select>
      tagName: "div"

      # DOM Events
      events:
        "change select": "change_select"

      # 初期化
      # @return [SelectView] void
      initialize: ->
        @select_tag = $('<select class="form-control"></select>')
        @model.on "create", @update_select_tag
        @model.on "change:items", @update_select_tag
        @update_select_tag()
        @

      # select tagを更新する
      # @return [SelectView] void
      update_select_tag: =>
        @select_tag.empty()
        items = @model.get "items"
        selected_key = @model.get "selected_key"
        _(items).each (item, key)=>
          @select_tag.append "<option value=\"#{key}\">#{item}</option>"
        @

      # アイテムが選択されたとき
      # @return [SelectView] void
      change_select: =>
        console.log @select_tag.val()
        @model.set "selected_key", @select_tag.val()
        @

      # DOMの描画
      # @return [SelectView] void
      render: ->
        @$el.empty()
        @$el.append @select_tag
        @
)

