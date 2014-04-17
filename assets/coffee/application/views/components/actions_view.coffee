define(
  [
    "misc/views/well_view"
  ]
  (
    WellView
  )->
    class ActionsView extends WellView

      # DOMの構築
      render: ->
        @$el.empty()
        @$el.append '<p class="bg-info">actions</p>'
        @$el.append '<button data-action="run-visualize" class="action-btn btn btn-lg btn-primary btn-block">Visualize</button>'
        @$el.append '<button disabled class="action-btn btn btn-lg btn-default btn-block">Save as Image</button>'
        @
)
