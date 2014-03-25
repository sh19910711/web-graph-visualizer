describe "misc/models/select_model", ->
  SpecHelpers.load_modules(
    "misc/models/select_model"
    "misc/models/item_model"
    "misc/collections/item_collection"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  context "コンストラクタのオプションの", ->
    context "itemsについて", ->
      context "何も渡さなかったとき", ->
        # TODO: 何か他にテストを追加したら消す
        it "dummy"

      context "空のItemCollectionを渡したとき", ->
        # TODO: 何か他にテストを追加したら消す
        it "dummy"

      context "空のArrayを渡したとき", ->
        # TODO: 何か他にテストを追加したら消す
        it "dummy"
        
      context "2つのItemModelが入ったItemCollectionを渡したとき", ->
        # TODO: 何か他にテストを追加したら消す
        it "dummy"
      
      context "2つのItemModelが入ったArrayを渡したとき", ->
        # TODO: 何か他にテストを追加したら消す
        it "dummy"

    context "selected_idについて", ->
      context "itemsに2つのItemModelが入ったitemCollectionを渡して", ->
        context "selected_idを渡さなかったとき", ->
          # TODO: 何か他にテストを追加したら消す
          it "dummy"

        context "selected_idを渡したとき", ->
          # TODO: 何か他にテストを追加したら消す
          it "dummy"
