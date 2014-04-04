require_relative 'lib/application/server'
require 'sprockets'

require 'mongoid'
Mongoid.load! 'mongoid.yml'

# http://.../lib/
map '/lib' do
  env = Sprockets::Environment.new
  env.append_path 'dist/js/lib/'
  run env
end

# http://.../js/
map '/js' do
  env = Sprockets::Environment.new
  env.append_path 'assets/coffee'
  run env
end

# http://.../css/
map '/css' do
  env = Sprockets::Environment.new
  env.css_compressor = :scss
  env.append_path 'assets/sass'
  run env
end

map '/' do
  run Application::Server
end

# development
if ENV['RACK_ENV'] == 'development'
  # http://.../test/
  map '/test' do
    env = Sprockets::Environment.new
    env.append_path 'spec/'
    env.append_path 'dist/test/'
    run env
  end

  # http://.../doc
  map '/doc' do
    run Rack::Directory.new(File.expand_path('doc', File.dirname(__FILE__)))
  end

  map '/test/load_coffee_script' do
    require_relative 'lib/debug/load_coffee_script'
    run Debug::LoadCoffeeScript
  end
end

I18n.enforce_available_locales = true

