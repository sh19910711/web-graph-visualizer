require_relative 'lib/application/server'
require 'sprockets'

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
