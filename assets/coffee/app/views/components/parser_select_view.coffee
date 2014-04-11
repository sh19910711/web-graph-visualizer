define(
  [
    "misc/views/well_view"
    "misc/views/tags/select_tag_view"
  ]
  (
    WellView
    SelectTagView
  )->
    # パーサーを選択するためのコンポーネント
    class ParserSelectView extends WellView
      # 初期化
      initialize: ->
        @select_view = new SelectTagView
          model: @model
          # 選択されているパーサーのモデル名をselected_parserに格納する
          key: "selected_parser"
          # model.get(items_key)に含まれるものをoptionタグに落とし込む
          items_key: "parser_keys"

      # DOMの構築
      render: ->
        @$el
          .empty()
          .append "<p class='bg-info'>parser select</p>"
          .append @select_view.render().el
        @
)
