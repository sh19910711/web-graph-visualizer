describe MongoidDummy::Models::DummyModel do
  context "create DummyModel instance without constructor option" do
    before :each do
      @dummy_model = MongoidDummy::Models::DummyModel.new
    end
    context "set key_1 to test" do
      before :each do
        @dummy_model.key_1 = "test"
      end
      context "get key_1" do
        subject { @dummy_model.key_1 }
        it { should eql "test" }
      end
    end
  end

  context "create DummyModel id=test1 instance with save()" do
    before :each do
      MongoidDummy::Models::DummyModel.save(
        _id: "test1",
        key_1: "value 1",
        key_2: "value 2",
      )
    end
    context "get id=test1" do
      before :each do
        @dummy_model = MongoidDummy::Models::DummyModel.find "test1"
      end
      context "get key_1" do
        subject { @dummy_model.key_1 }
        it { should eql "value 1" }
      end
      context "get key_2" do
        subject { @dummy_model.key_2 }
        it { should eql "value 2" }
      end
    end
  end
end
