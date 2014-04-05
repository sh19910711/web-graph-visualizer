require 'sinatra/base'
require_relative 'version'
require_relative 'config'
require_relative 'webapi'
require_relative 'models/input_text_model'
require_relative 'models/parser_model'

module Application
  class Server < Sinatra::Base
    register Config
    register WebAPI

    # ダミーのデータをつくる
    # ID = example_graph
    configure do
      example_id = "example_graph"
      unless Models::InputTextModel.where(:id => example_id).exists?
        Models::InputTextModel.create(
          :id => example_id,
          :text => "this is dummy input",
        )
      end
      unless Models::ParserModel.where(:id => example_id).exists?
        Models::ParserModel.create(
          :id => example_id,
          :type => "GraphParserExample",
          :options => [
            {
              :key => "dummy_1",
              :value => "fetched dummy text",
            },
          ]
        )
      end
    end

    get "/" do
      haml :index
    end

    get "/graphs/:graph_id" do
      haml :index
    end

    get "/version" do
      Application::VERSION_TEXT
    end
  end
end

