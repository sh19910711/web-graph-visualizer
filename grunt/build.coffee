module.exports = (grunt)->
  _ = require 'lodash'
  config = grunt.config()

  _(config).merge
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

  grunt.initConfig config

  # grunt build
  grunt.registerTask(
    'build'
    [
      'bower:build'
    ]
  )

