module Debug
  require 'sinatra/base'
  require 'pathname'

  class LoadCoffeeScript < Sinatra::Base
    get "/load_spec_files.js" do
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

      cur_path = File.expand_path(File.dirname(__FILE__) + "/../../")
      glob_path = cur_path + "/spec/coffee/{,**/}*_spec.coffee"
      Dir.glob glob_path do |filepath|
        pathname = Pathname(filepath)
        filepath = pathname.relative_path_from(Pathname cur_path).to_s
        filepath.gsub! /^spec\//, ""
        filepath.gsub! /\.coffee$/, ".js"
        res_text += "deferreds.push(load_script('/test/#{filepath}'));\n"
      end

      res_text += "$.when.apply(this, deferreds).done(function() { mocha_run(); });\n"
      res_text
    end
  end
end
