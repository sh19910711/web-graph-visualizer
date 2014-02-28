#
#     module_main.js.coffee
#

# AMD
define(
  [
    "./module_sub"
  ]
  (
    SubModule
  )->
    # 諸々確認用のダミーモジュール（CoffeeScript）
    class Module01
      # 1を返す
      get_one: ->
        1

      # 2を返す
      get_two: ->
        2

      # 3を返す
      get_three: ->
        # SubModuleを利用する
        module = new SubModule
        module.get_three
)
