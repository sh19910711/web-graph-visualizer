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
    context "GET /api/inputs/exist したとき" do
      before :each do
        get "/api/inputs/exist"
      end

      it "should return HTTP 200 OK" do
        expect(last_response.ok?).to be_true
      end

      it "should contain input_text as String" do
        obj = JSON.parse last_response.body
        expect(obj["input_text"]).to be_a String
      end
    end

    context "PUT /api/inputs/exist したとき" do
      before :each do
        put(
          "/api/inputs/exist",
          {
            :text => "update value",
          }.to_json,
          {
            "CONTENT_TYPE" => "application/json"
          },
        )
      end
      it "should update text" do
        model = Application::Models::GraphModel.find "exist"
        expect(model.input_text_model.text).to eql "update value"
      end
    end

    context "GET /api/inputs/not_exist したとき" do
      before :each do
        get "/api/inputs/not_exist"
      end

      it "should return HTTP 404" do
        expect(last_response.status).to eql 404
      end
    end
  end

  context "/api/parsersについて" do
    context "GET /api/parsers/exist したとき" do
      before :each do
        get "/api/parsers/exist"
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

    context "GET /api/parsers/not_exist したとき" do
      before :each do
        get "/api/parsers/not_exist"
      end

      it "should return HTTP 404" do
        expect(last_response.status).to eql 404
      end
    end

    context "PUT /api/parsers/exist したとき" do
      before :each do
        put(
          "/api/parsers/exist",
          {
            type: "NextParser",
            options: [
            ],
          }.to_json,
          {
            "CONTENT_TYPE" => "application/json",
          },
        )
      end

      it "should update parser values" do
        model = Application::Models::GraphModel.find "exist"
        expect(model.parser_model.type).to eql "NextParser"
      end
    end
  end

end
