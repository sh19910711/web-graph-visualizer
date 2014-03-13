describe "module_sune/test", ->
  # load tested modules
  beforeEach (done)=>
    requirejs(
      [
        'module_sune/test'
      ]
      (
        Sune
      )=>
        @module = new Sune
        done()
    )

  context "#get_42", =>
    it "should return 42", =>
      expect(@module.get_42()).to.equal 42

