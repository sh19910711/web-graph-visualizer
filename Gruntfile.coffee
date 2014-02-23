module.exports = (grunt)->
  # load tasks from `grunt` directory
  grunt.loadTasks 'grunt'

  # load npm module tasks
  pkg = grunt.file.readJSON 'package.json'
  for task of pkg.dependencies when /^grunt-/.test task
    grunt.loadNpmTasks task

