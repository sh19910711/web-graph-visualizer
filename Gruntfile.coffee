module.exports = (grunt)->
  grunt.initConfig {}
  
  # load tasks in `grunt` directory
  grunt.loadTasks 'grunt'

  # load npm module tasks
  pkg = grunt.file.readJSON 'package.json'
  for task of pkg.devDependencies when /^grunt-/.test task
    grunt.loadNpmTasks task

  # config: extend
  config = grunt.config()
  grunt.initConfig config

