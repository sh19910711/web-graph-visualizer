requirejs(
  [
    'module01/module_main'
    'module_ixxa/test'
    'module_sune/test'
  ]
  (
    Main
    Ixxa
    Sune
  )->
    console.log "after load modules"

    ixxa = new Ixxa
    console.log "ixxa = #{ixxa.get_message()}"

    sune = new Sune
    console.log "sune = #{sune.get_message()}"
)
