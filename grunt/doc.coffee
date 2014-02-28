module.exports = (grunt)->
  _       = require 'lodash'
  config  = grunt.config()

  # docco:doc_app
  _(config).merge
    docco:
      doc_app:
        src: [
          'assets/coffee/app/{,**/}*.coffee'
        ]
        options:
          output: 'doc/coffee/docco/app'

  # docco:doc_module01
  _(config).merge
    docco:
      doc_module01:
        src: [
          'assets/coffee/module01/{,**/}*.coffee'
        ]
        options:
          output: 'doc/coffee/docco/module01'

  # markdown:doc
  _(config).merge
    markdown:
      doc:
        files: [
          {
            expand: true
            cwd: 'doc_src'
            src: '{,**/}/*.md'
            dest: 'doc'
            ext: '.html'
          }
        ]

  # codo
  _(config).merge
    codo:
      options:
        output: 'doc/coffee/codo'
        inputs: ['assets/coffee']

  grunt.initConfig config

  # grunt concurrent:doc
  grunt.registerTask(
    'concurrent:doc'
    [
      'docco:doc_app'
      'docco:doc_module01'
      'codo'
      'markdown:doc'
    ]
  )

  # grunt doc
  grunt.registerTask(
    'doc'
    [
      'concurrent:doc'
    ]
  )

