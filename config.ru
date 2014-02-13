require_relative 'lib/application/server'
require 'sass/plugin/rack'

# Sass Config
Sass::Plugin.options[:style] = :compressed
Sass::Plugin.options[:template_location] = './src/sass/'
Sass::Plugin.options[:css_location] = './dist/css/'
Sass::Plugin.options[:cache_location] = './tmp/sass-cache/'
use Sass::Plugin::Rack

# Run Server
run Application::Server
