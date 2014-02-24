requirejs(
  [
    'app/application'
    'bootstrap'
  ]
  (
    Application
    _dummy_1
  )->
    console.log "after load modules"

    ixxa = new Application.Ixxa
    console.log "ixxa = #{ixxa.get_message()}"

    sune = new Application.Sune
    console.log "sune = #{sune.get_message()}"
)
