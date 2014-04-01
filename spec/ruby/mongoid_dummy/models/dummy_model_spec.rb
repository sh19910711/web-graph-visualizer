describe Dummy::Models::DummyModel do
  context "create DummyModel instance without constructor option" do
    before :each do
      @dummy_model = Dummy::Models::DummyModel.new
    end
    context "set key_1 to test" do
      before :each do
        @dummy_model.key_1 = "test"
      end
      it "test" do
        expect(@dummy_model.key_1).to eql "test"
      end
    end
  end
end
