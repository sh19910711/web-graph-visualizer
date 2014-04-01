# spec_helper.rb

ENV['RACK_ENV'] = 'test'
require 'mongoid'
Mongoid.load! 'mongoid.yml'

require_relative '../lib/application/module01'
require_relative '../lib/mongoid_dummy/models/dummy_model'

