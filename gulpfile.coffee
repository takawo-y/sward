gulp = require 'gulp'
coffee = require 'gulp-coffee'
ngmin = require 'gulp-ngmin'
uglify = require 'gulp-uglify'
less = require 'gulp-less'
clean = require 'gulp-rimraf'
bower = require 'bower'
nodemon = require 'gulp-nodemon'

gulp.task 'bower', ->
  bower.commands.install().on 'end', (installed) ->
    gulp.src([
      'bower_components/bootstrap/dist/css/bootstrap.min.css'
      'bower_components/bootstrap/dist/css/bootstrap-theme.min.css'
      'bower_components/angular/angular.min.js'
    ]).pipe gulp.dest('dist/bower/')

gulp.task 'js', ->
  gulp.src('app/app.coffee')
      .pipe(coffee())
      .pipe(ngmin())
      .pipe(uglify())
      .pipe gulp.dest('dist/js/')

gulp.task 'css', ->
  gulp.src('app/app.less')
      .pipe(less())
      .pipe gulp.dest('dist/css/')

gulp.task 'static', ->
  gulp.src([
    'manifest.json'
    'newtab.html'
    'bower_components/bootstrap/dist/fonts/'
  ]).pipe gulp.dest('dist/')

gulp.task 'clean', ->
  gulp.src('dist/').pipe clean()

gulp.task 'watch', ->
  gulp.watch [
    '*.coffee'
    '*.less'
    '*.html'
  ], -> gulp.start 'js', 'css', 'static'

gulp.task 'default', ['clean'], ->
  gulp.start 'bower', 'js', 'css', 'static'
