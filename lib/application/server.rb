require 'sinatra/base'
require_relative 'version'

module Application
  class Server < Sinatra::Base
    get "/version" do
      Application::VERSION_TEXT
    end
  end
end

