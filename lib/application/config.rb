module Application
  module Config
    def self.registered(app)
      app.set :public_folder, './dist/'
    end
  end
end

