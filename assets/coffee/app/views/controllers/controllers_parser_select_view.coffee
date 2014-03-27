define(
  [
    "backbone"
    "misc/views/select_view"
    "./well_view"
  ]
  (
    Backbone
    SelectView
    WellView
  )->
    # パーサーの選択
    class ControllersParserSelectView extends WellView
      initialize: ->
        @parser_select_view = new SelectView
          model: @model.get "parser_select"
        @update()
        @model.on "change:parsers", =>
          @update()
        @

      update: ->
        parsers = @model.get "parsers"
        parser_select = @model.get "parser_select"
        parser_keys = _(parsers).keys()
        items = parser_select.get("items")
        _(parser_keys).each (parser_key)=>
          items.add
            id: parser_key
            value: parser_key

      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">parsers</p>'
        @$el.append @parser_select_view.render().el
        @
)
