require 'spec_helper'

describe Application::WebAPI do
  include Rack::Test::Methods

  class DummyWebServer < Sinatra::Base
    register Application::WebAPI
  end

  def app
    DummyWebServer
  end

  context "/api/inputsについて" do
    context "GET /api/inputs/exist.json したとき" do
      before :each do
        get "/api/inputs/exist.json"
      end

      it "should return HTTP 200 OK" do
        last_response.ok?.should be_true
      end

      it "should contain input_text as String" do
        obj = JSON.parse last_response.body
        expect(obj["input_text"]).to be_a String
      end
    end

    context "GET /api/inputs/not_exist.json したとき" do
      before :each do
        get "/api/inputs/not_exist.json"
      end

      it "should return HTTP 404" do
        last_response.status.should eql 404
      end
    end
  end
end
