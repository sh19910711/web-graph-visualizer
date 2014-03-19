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
        # 選択可能なアイテムのリスト（ItemCollection）
        items: undefined
        # 選択されているアイテムのID
        selected_id: undefined

      # 初期化
      # @return [SelectModel] void
      initialize: ->
        @
)
