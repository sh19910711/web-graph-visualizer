module.exports = (grunt)->
  _       = require 'lodash'
  config  = grunt.config()

  # docco:doc_app
  _(config).merge
    docco:
      doc_app:
        src: [
          'assets/coffee/application/{,**/}*.coffee'
        ]
        options:
          output: 'tmp/doc/coffee/docco/app'

  # docco:doc_module01
  _(config).merge
    docco:
      doc_module01:
        src: [
          'assets/coffee/module01/{,**/}*.coffee'
        ]
        options:
          output: 'tmp/doc/coffee/docco/module01'

  # markdown:doc
  _(config).merge
    markdown:
      doc:
        files: [
          {
            expand: true
            cwd: 'doc'
            src: '{,**/}/*.md'
            dest: 'tmp/doc'
            ext: '.html'
          }
        ]

  # codo
  _(config).merge
    codo:
      options:
        output: 'tmp/doc/coffee/codo'
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

