# spec_helper.rb

#
# MongoDB
#
ENV['RACK_ENV'] = 'test'
require 'mongoid'

# サーバーに関する設定の読み込み
Mongoid.load! 'mongoid.yml', ENV['RACK_ENV'].to_sym

# create()などで直接IDを指定できるようにするための設定
Mongoid.protect_sensitive_fields = false

require 'byebug'

require_relative '../lib/application/module01'
require_relative '../lib/application/models/input_text_model'
require_relative '../lib/mongoid_dummy/models/dummy_model'

