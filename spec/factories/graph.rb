require_relative '../../lib/application/models/graph_model'

FactoryGirl.define do |f|
  # 存在するかどうかで分岐させるときに利用する
  factory :graph_exist, :class => Application::Models::GraphModel do
    id "exist"
    input_text_model { FactoryGirl.build :input_text_exist }
    parser_model { FactoryGirl.build :parser_exist }
  end
end
