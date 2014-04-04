describe Application::Models::ParserModel do
  context "とりあえず動作確認" do
    context "new()でモデルのインスタンスを生成して" do
      before :each do
        @parser = Application::Models::ParserModel.new
      end
      context "typeにtype 1と代入して" do
        before :each do
          @parser.type = "type 1"
        end
        context "read_attribute()を実行すると" do
          before :each do
            @ret = @parser.read_attribute :type
          end
          it "should return type 1" do
            expect(@ret).to eql "type 1"
          end
        end
      end
    end
  end

  context "options fieldについて" do
    context "new()でモデルのインスタンスを生成して" do
      before :each do
        @parser = Application::Models::ParserModel.new
      end
      context "optionsに{key=key1, value=value1}を追加して" do
        before :each do
          @parser.push :options, {
            :key => "key1",
            :value => "value1",
          }
        end
        context "optionsを取得して" do
          before :each do
            @options = @parser.options
          end
          context "何もしないとき" do
            it "should have one element" do
              expect(@options.length).to eql 1
            end
          end
          context "optionsのkeyを取り出すと" do
            before :each do
              @keys = @options.map {|option| option[:key] }
            end
            it "should include key1" do
              expect(@keys).to include "key1"
            end
          end
          context "optionsのvalueを取り出すと" do
            before :each do
              @values = @options.map {|option| option[:value] }
            end
            it "should include value1" do
              expect(@values).to include "value1"
            end
          end
        end
      end
    end
  end
end
