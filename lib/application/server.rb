require 'sinatra/base'
require_relative 'version'
require_relative 'config'
require_relative 'webapi'
require_relative 'models/graph_model'
require_relative 'models/input_text_model'
require_relative 'models/parser_model'

module Application
  class Server < Sinatra::Base
    register Config
    register WebAPI

    get "/" do
      haml :index
    end

    get "/graphs/:graph_id" do
      haml :index
    end

    # 新しくグラフをつくる
    post "/graphs" do
      params = JSON.parse request.body.read
      graph = Application::Models::GraphModel.create
      if graph.save
        content_type "json"
        res = {
          :graph_id => graph.id,
        }
        json res
      else
        status 503
        "503 ERROR"
      end
    end

    get "/version" do
      Application::VERSION_TEXT
    end
  end
end

