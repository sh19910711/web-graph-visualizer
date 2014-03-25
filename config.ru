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

  map '/test/load_spec_files.js' do
    # TODO: ファイルに分割する
    require 'sinatra/base'
    class SpecLoader < Sinatra::Base
      get "/" do
        content_type "text/javascript"
        res_text = ""

        script_tag = ""
        script_tag += "function load_script(path) {\n"
        script_tag += "  var deferred = new $.Deferred;\n"
        script_tag += "  var head= document.getElementsByTagName('head')[0];\n"
        script_tag += "  var script= document.createElement('script');\n"
        script_tag += "  script.type= 'text/javascript';\n"
        script_tag += "  script.onreadystatechange= function () {\n"
        script_tag += "    if (this.readyState == 'complete') deferred.resolve();\n"
        script_tag += "  }\n"
        script_tag += "  script.onload = deferred.resolve;\n"
        script_tag += "  script.src = path;\n"
        script_tag += "  head.appendChild(script);\n"
        script_tag += "  return deferred;\n"
        script_tag += "}\n"
        script_tag += "var deferreds = [];\n"
        res_text += script_tag

        Dir.glob "spec/coffee/{,**/}*_spec.coffee" do |filepath|
          filepath.gsub! /^spec\//, ""
          filepath.gsub! /\.coffee$/, ".js"
          res_text += "deferreds.push(load_script('/test/#{filepath}'));\n"
        end

        res_text += "$.when.apply(this, deferreds).done(function() { mocha_run(); });\n"
        res_text
      end
    end
    run SpecLoader
  end
end
