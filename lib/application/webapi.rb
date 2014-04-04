require "sinatra/json"

module Application
  module WebAPI
    def self.registered(app)
      app.get "/api/inputs/:graph_id.json" do
        # test
        res = {
          status: "this is dummy: graph_id = #{params[:graph_id]}"
        }
        json res
      end
    end
  end
end

