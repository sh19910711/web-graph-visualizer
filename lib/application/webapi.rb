require "sinatra/json"
require_relative 'models/input_text_model'

module Application
  module WebAPI
    def self.registered(app)
      # GET /api/inputs/xxx.json
      app.get "/api/inputs/:graph_id.json" do
        graph_id = params[:graph_id]
        begin
          input_text = Application::Models::InputTextModel.find graph_id
          # データが存在するときは、input_textにデータを入れて返す
          res = {
            :input_text => input_text.text,
          }
          json res
        rescue
          # 存在しないときは、404エラーを返す
          # TODO: 存在しないとき以外のエラーへの対応
          status 404
          res = {
            :status => "Not Found",
          }
          json res
        end
      end

      # GET /api/parsers/xxx.json
      app.get "/api/parsers/:graph_id.json" do
        graph_id = params[:graph_id]
        json {}
      end
    end
  end
end

