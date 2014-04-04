require 'spec_helper'

describe Application::Models::InputTextModel do
  context "new()で生成して" do
    before :each do
      @input_text = Application::Models::InputTextModel.new
    end
    context "write_attribute()で文字列を設定して" do
      before :each do
        @input_text.write_attribute :text, "this is text"
      end
      context "read_attribute()で文字列を取得すると" do
        subject do
          @input_text.read_attribute :text
        end
        it "should equal this is text" do
          should eql "this is text"
        end
      end
    end
  end

  context "create()で生成して" do
    before :each do
      @input_text = Application::Models::InputTextModel.create(
        :id => "test"
      )
    end
    context "write_attribute()で文字列を設定して" do
      before :each do
        @input_text.write_attribute :text, "this is text"
        raise Error "test" unless @input_text.save()
      end
      context "find()を使って新しいインスタンスを作り直してから" do
        before :each do
          @input_text_new = Application::Models::InputTextModel.find "test"
        end
        context "read_attribute()で値を取得すると" do
          before :each do
            @ret = @input_text_new.read_attribute :text
          end
          it "should equal this is text" do
            expect(@ret).to eql "this is text"
          end
        end
      end
    end
  end
end
