describe "module_ixxa/test", ->
  # load tested modules
  beforeEach (done)=>
    requirejs(
      [
        'module_ixxa/test'
      ]
      (
        Ixxa
      )=>
        @module = new Ixxa
        done()
    )

  context "#get_42", =>
    it "should return 42 [TODO] remove", =>
      expect(@module.get_42()).to.equal 42

