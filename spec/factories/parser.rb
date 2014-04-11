require_relative "../../lib/application/models/parser_model"

FactoryGirl.define do |f|
  # 存在するかどうかで分岐させるときに利用する
  factory :parser_exist, :class => Application::Models::ParserModel do
    graph_model_id "exist"
    type "some_parser"
    options [
      {
        :key => "key 1",
        :value => "value 1",
      },
      {
        :key => "key 2",
        :value => "value 2",
      },
    ]
  end
end
