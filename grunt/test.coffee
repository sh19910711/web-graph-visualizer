module.exports = (grunt)->
  _      = require 'lodash'
  path   = require 'path'
  config = grunt.config()

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
          middleware: (connect)->
            [
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

