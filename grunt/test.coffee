module.exports = (grunt)->
  _      = require 'lodash'
  path   = require 'path'
  config = grunt.config()

  # CoffeeScriptのテストコード読み込みを自動化する
  load_spec_files = (req, res, next)->
    url  = require 'url'
    glob = require 'glob'
    pathname = url.parse(req.url).pathname
    if req.method == 'GET' && pathname == '/test/load_spec_files.js'
      res_text = ''
      glob 'spec/coffee/{,**/}*_spec.coffee', {}, (error, files)->
        files = _(files).map (filepath)->
          filepath.replace /\.coffee$/, '.js'
        files = _(files).map (filepath)->
          filepath.replace /^spec\//, ''

        script_tag = ""
        script_tag += "function load_script(path) {\n"
        script_tag += "  console.log('load_script', path);"
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

        _(files).each (filepath)->
          res_text += "deferreds.push(load_script('/test/#{filepath}'));\n"

        res_text += "$.when.apply(this, deferreds).done(function() { mocha_run(); });\n"
        res.setHeader 'Content-Type', 'application/x-javascript'
        res.setHeader 'Content-Length', res_text.length
        res.end res_text
    else
      next()

  # bower:test
  _(config).merge
    bower:
      test:
        options:
          targetDir:      'dist/test/lib/'
          layout:         'byComponent'
          install:        true
          verbose:        true
          cleanTargetDir: false
          cleanBowerDir:  false
          production:     false

  # coffee:test_* | compile coffee
  _(config).merge
    coffee:
      test_assets:
        expand: true
        cwd: 'assets/coffee'
        src: [
          '**/*.coffee'
        ]
        dest: 'dist/test/js/'
        ext: '.js'
      test_spec:
        expand: true
        cwd: 'spec/coffee/'
        src: [
          '**/*.coffee'
        ]
        dest: 'dist/test/coffee/'
        ext: '.js'

  # connect:test | run server
  _(config).merge
    connect:
      test:
        options:
          port: 39000
          hostname: 'localhost'
          keepalive: process.env['CONNECT_KEEPALIVE'] == 'true'
          middleware: (connect)->
            [
              load_spec_files
              connect.static path.resolve('spec/')
              connect.static path.resolve('dist/')
            ]

  # mocha_phantomjs
  _(config).merge
    mocha_phantomjs:
      test:
        options:
          reporter: 'tap'
          output: 'tmp/test/result-coffee.txt'
          urls: [
            'http://localhost:39000/test_coffee.html'
          ]

  grunt.initConfig config

  # grunt concurrent:test
  grunt.registerTask(
    'concurrent:test'
    [
      'bower:test'
      'coffee:test_assets'
      'coffee:test_spec'
    ]
  )

  # grunt test
  grunt.registerTask(
    'test'
    [
      'concurrent:test'
      'connect:test'
      'mocha_phantomjs:test'
    ]
  )

