describe "module01/module_main", ->
  # load tested modules
  beforeEach (done)=>
    requirejs(
      [
        'module01/module_main'
      ]
      (
        Module01
      )=>
        @module = new Module01
        done()
    )

  context "get", =>
    it "#get_one", =>
      expect(@module.get_one()).to.eql 1

    it "#get_two", =>
      expect(@module.get_two()).to.eql 2

    it "#get_three", =>
      expect(@module.get_three()).to.eql 3

