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
    it "#get_one", ()=>
      chai.expect(@module.get_one()).to.eq 1

    it "#get_two", ()=>
      chai.expect(@module.get_two()).to.eq 2

    it "#get_three", ()=>
      chai.expect(@module.get_three()).to.eq 3

