#
#     module_main.js.coffee
#

# AMD
define(
  [
    "./module_sub"
    "backbone"
  ]
  (
    SubModule
    Backbone
  )->
    # 諸々確認用のダミーモジュール（CoffeeScript）
    class Module01 extends Backbone.Model
      initialize: ->

      # 1を返す
      #
      # @return {Number} 1
      get_one: ->
        1

      # 2を返す
      #
      # @return {Number} 2
      get_two: ->
        2

      # 3を返す
      #
      # @return {Number} 3
      get_three: ->
        # SubModuleを利用する
        module = new SubModule
        module.get_three
)
