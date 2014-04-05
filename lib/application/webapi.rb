require "sinatra/json"
require_relative 'models/input_text_model'
require_relative 'models/parser_model'

module Application
  module WebAPI
    def self.registered(app)
      # GET /api/inputs/xxx
      app.get "/api/inputs/:graph_id" do
        graph_id = params[:graph_id]
        begin
          graph = Application::Models::GraphModel.find graph_id
          # データが存在するときは、input_textにデータを入れて返す
          res = {
            :input_text => graph.input_text_model.text,
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

      # GET /api/parsers/xxx
      app.get "/api/parsers/:graph_id" do
        graph_id = params[:graph_id]
        begin
          # データが存在するときは、type, optionsにデータを入れて返す
          graph = Application::Models::GraphModel.find graph_id
          res = {
            :type => graph.parser_model.type,
            :options => graph.parser_model.options,
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
    end
  end
end

