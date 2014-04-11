require "spec_helper"

describe Application::Server do
  include Rack::Test::Methods

  def app
    Application::Server
  end

  context "/graphsについて" do
    context "POST /graphs" do
      before :each do
        data = {
          :input_text => "this is dummy",
          :parser_type => "GraphParserExample",
          :parser_options => [
            {
              :key => "dummy_1",
              :value => "post value",
            },
          ],
        }
        post "/graphs", data.to_json, { "CONTENT_TYPE" => "application/json" }
      end

      context "last_responseについて" do
        it "should not be redirect" do
          expect(last_response).to_not be_redirect
        end

        it "should be ok" do
          expect(last_response.ok?).to be_true
        end
      end
    end
  end
end

