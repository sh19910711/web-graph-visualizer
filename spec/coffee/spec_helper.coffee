@expect = chai.expect
@sinon = sinon

class @SpecHelpers
  # 可変引数で読み込むモジュールのパスを渡すと
  # モジュールの読み込みを行う
  #
  # Usage:
  # SpecHelpers.load_modules(
  #   "path/to/module01"
  #   "path/to/module02"
  # )
  #
  # @return [context] void
  @load_modules: ->
    # 与えられた引数を配列に変換する
    modules = Array::splice.call arguments, 0

    beforeEach (done)->
      @timeout 5000

      requirejs modules, =>
        # modulesが未定義のときは空のオブジェクトとして初期化する
        @modules ||= {}
        # @modules.{ClassName}としてアクセスできるように設定する
        Array::forEach.call arguments, (ModuleClass)=>
          @modules[ModuleClass.name] = ModuleClass
        # callback
        done()

    afterEach ->
      delete @modules

    @

