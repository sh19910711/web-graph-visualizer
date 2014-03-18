describe "coffee/parser/graph/adjacent_list_parser", ->
  beforeEach (done)->
    requirejs(
      [
        "parser/graph/adjacent_list_parser"
      ]
      (
        ParserClass
      )=>
        @ParserClass = ParserClass
        done()
    )
  
  # TODO: 何か他にテストを追加したら消す
  it "dummy"
