define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    # 選択可能なアイテムのリスト
    class SelectModel extends Backbone.Model
      # 初期値
      defaults: ->
        # 選択可能なアイテムのリスト
        # items[key] = 表示名
        items: []
        # 選択されているアイテムのID
        selected_key: undefined

      # 初期化
      # @return [SelectModel] void
      initialize: ->
        @
)
