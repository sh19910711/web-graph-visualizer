#
#     main.js.coffee
#

# load modules
requirejs(
  [
    'app/application'
    'bootstrap'
  ]
  (
    Application
    _dummy_1
  )->
    # モジュールが読み込まれたあとに実行される部分
    console.log "after load modules"

    # 練習用
    #
    # * https://github.com/sh19910711/web-graph-visualizer/issues/3
    ixxa = new Application.Ixxa
    console.log "ixxa = #{ixxa.get_message()}"
    sune = new Application.Sune
    console.log "sune = #{sune.get_message()}"
)

