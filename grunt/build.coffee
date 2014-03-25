module.exports = (grunt)->
  _      = require 'lodash'
  config = grunt.config()

  # bower:build
  _(config).merge
    bower:
      build:
        options:
          targetDir:      'dist/js/lib/'
          layout:         'byComponent'
          install:        true
          verbose:        true
          cleanTargetDir: false
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

