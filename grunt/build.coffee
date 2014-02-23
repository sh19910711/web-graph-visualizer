module.exports = (grunt)->
  _ = require 'underscore'
  config = grunt.config()

  _(config).extend
    bower:
      'build':
        options:
          targetDir:      "dist/js/lib/"
          layout:         "byComponent"
          install:        true
          verbose:        true
          cleanTargetDir: true
          cleanBowerDir:  false
          production:     true
      'test':
        options:
          targetDir:      "dist/test/lib/"
          layout:         "byComponent"
          install:        true
          verbose:        true
          cleanTargetDir: true
          cleanBowerDir:  false
          production:     false

  grunt.initConfig config

  # grunt build
  grunt.registerTask(
    'build'
    [
      'bower:build'
    ]
  )

