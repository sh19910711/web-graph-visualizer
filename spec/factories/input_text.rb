require_relative '../../lib/application/models/input_text_model'

FactoryGirl.define do |f|
  # 存在するかどうかで分岐させるときに利用する
  factory :input_text_exist, :class => Application::Models::InputTextModel do
    id "exist"
    text "this is a existing case"
  end
end
