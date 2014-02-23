define(
  [
    "./module_sub"
  ]
  (
  )->
    console.log "this is module01"
    class Module01
      get_one: ->
        1
      get_two: ->
        2
      get_three: ->
        3
)
