define(
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
    class Application
      @Ixxa: Ixxa
      @Sune: Sune
)
