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
          output: 'doc/coffee/app'

  # docco:doc_module01
  _(config).merge
    docco:
      doc_module01:
        src: [
          'assets/coffee/module01/{,**/}*.coffee'
        ]
        options:
          output: 'doc/coffee/module01'

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

  grunt.initConfig config

  # grunt concurrent:doc
  grunt.registerTask(
    'concurrent:doc'
    [
      'docco:doc_app'
      'docco:doc_module01'
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

