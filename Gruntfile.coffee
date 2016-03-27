fs = require 'fs'
yaml = require 'yaml'

module.exports = (grunt) ->
  (require 'load-grunt-tasks') grunt

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    mochaTest:
      test:
        options:
          require: ['coffee-script/register']
        src: ['test/*.coffee']
      coverage:
        options:
          require: ['coffee-script/register', 'blanket']
          reporter: 'html-cov'
          quiet: yes
          captureFile: 'coverage.html'
        src: ['test/*.coffee']
    coffee:
      lib:
        files:
          'lib/yabasky.js': 'src/yabasky.coffee'
      bin:
        options:
          'no-header': yes
          bare: yes
        files:
          'bin/yabasky':     'src/executable.coffee'
    codo:
      src: ['src']

  grunt.registerTask 'coverage', ['build', 'mochaTest:coverage']
  grunt.registerTask 'test',     ['build', 'mochaTest:test']
  grunt.registerTask 'build',    'coffee'
  grunt.registerTask 'version', () ->
    content = fs.readFileSync './style/yabasky.yaml', encoding: 'utf-8'
    style = yaml.eval content
    grunt.log.writeln "YaBAskY: #{grunt.config.get 'pkg.version'}"
    grunt.log.writeln "style:   #{style.version}"
    
  grunt.registerTask 'clean', () ->
    grunt.file.delete file, force: yes for file in [
      'bin'
      'doc'
      'lib'
      'coverage.html'
    ]
    
  grunt.registerTask 'default', 'version'
