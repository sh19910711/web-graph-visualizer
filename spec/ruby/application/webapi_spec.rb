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
    end
  end
end
