require 'mongoid'
Mongoid.load! 'mongoid.yml', :development

require_relative 'lib/application/webapi'
require_relative 'lib/application/module01'
require_relative 'lib/application/models/input_text_model'
require_relative 'lib/application/models/parser_model'
require_relative 'lib/application/models/graph_model'
require_relative 'lib/mongoid_dummy/models/dummy_model'


