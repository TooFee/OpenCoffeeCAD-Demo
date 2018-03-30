import dd from 'ddeyes'
import del from 'del'

import gulp from 'gulp'
import gulpSequence from 'gulp-sequence'
import replace from 'gulp-string-replace'
import minify from 'gulp-babel-minify'

import inputJs from './inputJs'

import rollup from 'gulp-better-rollup'
import {
  coffee2
  coffeepath
} from 'cfx.rollup-plugin-coffee2'
import cleanup from 'rollup-plugin-cleanup'

gulp.task 'clean', (cb) =>
  del [
    './build'
    './dist'
  ]
  , cb

gulp.task 'build', =>

  gulp.src './example/**/*.coffee'
  .pipe inputJs()
  .pipe gulp.dest './build'

gulp.task 'dist', =>

  gulp.src './build/**/*.js'
  .pipe rollup
    plugins: [
      coffee2
        bare: true
        sourceMap: true
      coffeepath()
      cleanup()
    ]
    , 'iife'
  .pipe replace /\(function \(\) {/g, ''
  .pipe replace /}\(\)\);/g, ''
  .pipe replace /main\(\);/g, ';'
  .pipe minify
    mangle:
      keepClassName: true
  .pipe gulp.dest './dist'

gulp.task 'default'
,
  gulpSequence(
    'clean'
    'build'
    'dist'
  )
