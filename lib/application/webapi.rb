require "sinatra/json"
require_relative 'models/input_text_model'
require_relative 'models/parser_model'

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
        begin
          # データが存在するときは、type, optionsにデータを入れて返す
          parser = Application::Models::ParserModel.find graph_id
          res = {
            :type => parser.type,
            :options => parser.options,
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

