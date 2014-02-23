module.exports = (grunt)->
  _ = require 'underscore'
  path = require 'path'
  config = grunt.config()

  # compile coffee
  _(config).extend
    coffee:
      test_assets:
        expand: true
        cwd: "assets/coffee"
        src: [
          '**/*.coffee'
        ]
        dest: 'dist/test/js/'
        ext: '.js'
      test_spec:
        expand: true
        cwd: "spec/coffee/"
        src: [
          '**/*.coffee'
        ]
        dest: 'dist/test/test/'
        ext: '.js'

  # run server
  _(config).extend
    connect:
      test:
        options:
          port: 39000
          hostname: 'localhost'
          middleware: (connect)->
            [
              connect.static path.resolve('spec/')
              connect.static path.resolve('dist/test/')
            ]

  # mocha_phantomjs
  _(config).extend
    mocha_phantomjs:
      test:
        options:
          reporter: 'dot'
          urls: [
            "http://localhost:39000/test_coffee.html"
          ]

  grunt.initConfig config

  # grunt test
  grunt.registerTask(
    'test'
    [
      'bower:test'
      'coffee:test_assets'
      'coffee:test_spec'
      'connect:test'
      'mocha_phantomjs:test'
    ]
  )

