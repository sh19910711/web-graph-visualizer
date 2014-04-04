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
        expect(last_response.ok?).to be_true
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
        expect(last_response.status).to eql 404
      end
    end
  end

  context "/api/parsersについて" do
    context "GET /api/parsers/exist.json したとき" do
      before :each do
        get "/api/parsers/exist.json"
      end

      it "should return HTTP 200 OK" do
        expect(last_response.ok?).to be_true
      end

      it "should contain type as String" do
        ret = JSON.parse(last_response.body)["type"]
        expect(ret).to be_a String
      end

      it "should contain options as Array" do
        ret = JSON.parse(last_response.body)["options"]
        expect(ret).to be_a Array
      end

      it "should contain two elements in options" do
        ret = JSON.parse(last_response.body)["options"]
        expect(ret.length).to eql 2
      end
    end

    context "GET /api/parsers/not_exist.json したとき" do
      before :each do
        get "/api/parsers/not_exist.json"
      end

      it "should return HTTP 404" do
        expect(last_response.status).to eql 404
      end
    end
  end

end
