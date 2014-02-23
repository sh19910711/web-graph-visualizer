require 'sinatra/reloader'

module Application
  module Config
    def self.registered(app)
      app.configure :development do
        app.register Sinatra::Reloader
      end
    end
  end
end

