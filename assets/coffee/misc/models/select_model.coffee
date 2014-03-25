define(
  [
    "backbone"
    "misc/collections/item_collection"
  ]
  (
    Backbone
    ItemCollection
  )->
    # 選択可能なアイテムのリスト
    class SelectModel extends Backbone.Model
      # 初期値
      defaults: ->
        # 選択可能なアイテムのリスト（ItemCollection）
        items: undefined
        # 選択されているアイテムのID
        selected_id: undefined

      # 初期化
      # @return [SelectModel] void
      initialize: (options)->
        items = @get "items"
        # itemsがItemCollectionじゃないときに初期化する
        unless items instanceof ItemCollection
          if items instanceof Array
            items = new ItemCollection items
          else
            throw new Error "ERROR_DQXE6Q: Invalid Items"

        items.on "add", =>
          @trigger "change:items"
        items.on "remove", =>
          @trigger "change:items"
        @set "items", items

        # selected_idが設定されていない時はitemsの最初の要素のidで初期化する
        unless @get "selected_id"
          @set "selected_id", @get("items").first().id if @get("items").length

        @
)
