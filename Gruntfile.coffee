module.exports = (grunt)->
  _ = require 'underscore'

  # load tasks from `grunt` directory
  grunt.loadTasks 'grunt'

  # load npm module tasks
  pkg = grunt.file.readJSON 'package.json'
  for task of pkg.dependencies when /^grunt-/.test task
    grunt.loadNpmTasks task

  # grunt build
  grunt.registerTask(
    'build'
    [
      'bower:build'
    ]
  )

  # task config: extend
  config = {}

  _(config).extend
    bower:
      'build':
        options:
          targetDir:      "dist/js/lib/"
          layout:         "byComponent"
          install:        true
          verbose:        true
          cleanTargetDir: true
          cleanBowerDir:  true

  grunt.initConfig config

