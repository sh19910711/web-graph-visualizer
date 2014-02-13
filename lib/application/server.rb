require 'sinatra/base'
require_relative 'version'
require_relative 'config'

module Application
  class Server < Sinatra::Base
    register Config

    get "/version" do
      Application::VERSION_TEXT
    end
  end
end

