require 'sinatra/base'
require_relative 'version'
require_relative 'config'
require_relative 'webapi'

module Application
  class Server < Sinatra::Base
    register Config
    register WebAPI

    get "/" do
      haml :index
    end

    get "/version" do
      Application::VERSION_TEXT
    end
  end
end

