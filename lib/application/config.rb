require 'sinatra/reloader'

module Application
  module Config
    def self.registered(app)
      app.configure :development do
        app.register Sinatra::Reloader
        app.set :haml, :attr_wrapper => '"'
      end
    end
  end
end

