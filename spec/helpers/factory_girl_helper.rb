require 'factory_girl'

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.before :each do
    FactoryGirl.create :input_text_exist
    FactoryGirl.create :parser_exist
  end
  config.after :each do
    FactoryGirl.reload
  end
end


