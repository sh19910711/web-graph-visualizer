define(
  [
    "backbone"
  ]
  (
    Backbone
  )->
    # idとvalueの対応
    class ItemModel extends Backbone.Model
      # 初期値
      defaults:
        id: undefined
        value: undefined

      # 初期化
      # @return [ItemModel] void
      initialize: ->
        @

)

