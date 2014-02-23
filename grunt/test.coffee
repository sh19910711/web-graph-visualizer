module.exports = (grunt)->
  _ = require 'underscore'
  config = grunt.config()

  _(config).extend
    mocha_phantomjs:
      test: [
        "http://localhost:4000/test/test_coffee.html"
      ]

  grunt.initConfig config

  # grunt test
  grunt.registerTask(
    'test'
    [
      'bower:test'
      'mocha_phantomjs:test'
    ]
  )

