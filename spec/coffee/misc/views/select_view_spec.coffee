describe "misc/views/select_view", ->
  SpecHelpers.load_modules(
    "misc/models/select_model"
    "misc/views/select_view"
    "misc/models/item_model"
    "misc/collections/item_collection"
  )

  beforeEach ->
    @data = {}

  afterEach ->
    delete @data

  context "5個のアイテムを持つModelを設定して", ->
    beforeEach ->
      @data.model = new @modules.SelectModel
        items: new @modules.ItemCollection(
          [
            new @modules.ItemModel
              id: "test-1"
              value: "test 1"
            new @modules.ItemModel
              id: "test-2"
              value: "test 2"
            new @modules.ItemModel
              id: "test-3"
              value: "test 3"
            new @modules.ItemModel
              id: "test-4"
              value: "test 4"
            new @modules.ItemModel
              id: "test-5"
              value: "test 5"
          ]
        )
      @data.view = new @modules.SelectView
        model: @data.model
      @data.view.render()

    context "何もしないとき", ->
      context "Modelについて", ->
        it "should select test-1", ->
          expect(@data.model.get("selected_id")).to.equals "test-1"

      context "DOMについて", ->
        it "should select test-1", ->
          expect(@data.view.$el.find("select").val()).to.equals "test-1"

    context "test-1を選択したとき", ->
      beforeEach ->
        @data.view.$el.find("select").val("test-1").trigger("change")

      context "Modelについて", ->
        it "should select test-1", ->
          expect(@data.model.get("selected_id")).to.equals "test-1"

      context "DOMについて", ->
        it "should select test-1", ->
          expect(@data.view.$el.find("select").val()).to.equals "test-1"

    context "test-2を選択したとき", ->
      beforeEach ->
        @data.view.$el.find("select").val("test-2").trigger("change")

      context "Modelについて", ->
        it "should select test-2", ->
          expect(@data.model.get("selected_id")).to.equals "test-2"

      context "DOMについて", ->
        it "should select test-2", ->
          expect(@data.view.$el.find("select").val()).to.equals "test-2"

  context "5個のアイテムを持ち、test-3が選択されているModelを設定して", ->
    beforeEach ->
      @data.model = new @modules.SelectModel
        items: new @modules.ItemCollection(
          [
            new @modules.ItemModel
              id: "test-1"
              value: "test 1"
            new @modules.ItemModel
              id: "test-2"
              value: "test 2"
            new @modules.ItemModel
              id: "test-3"
              value: "test 3"
            new @modules.ItemModel
              id: "test-4"
              value: "test 4"
            new @modules.ItemModel
              id: "test-5"
              value: "test 5"
          ]
        )
        selected_id: "test-3"
      @data.view = new @modules.SelectView
        model: @data.model
      @data.view.render()

    context "何もしないとき", ->
      context "Modelについて", ->
        it "should select test-3", ->
          expect(@data.model.get("selected_id")).to.equals "test-3"

      context "DOMについて", ->
        it "should select test-3", ->
          expect(@data.view.$el.find("select").val()).to.equals "test-3"

    context "test-1を選択したとき", ->
      beforeEach ->
        @data.view.$el.find("select").val("test-1").trigger("change")

      context "Modelについて", ->
        it "should select test-1", ->
          expect(@data.model.get("selected_id")).to.equals "test-1"

      context "DOMについて", ->
        it "should select test-1", ->
          expect(@data.view.$el.find("select").val()).to.equals "test-1"

    context "test-2を選択したとき", ->
      beforeEach ->
        @data.view.$el.find("select").val("test-2").trigger("change")

      context "Modelについて", ->
        it "should select test-2", ->
          expect(@data.model.get("selected_id")).to.equals "test-2"

      context "DOMについて", ->
        it "should select test-2", ->
          expect(@data.view.$el.find("select").val()).to.equals "test-2"

