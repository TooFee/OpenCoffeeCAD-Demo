# import dd from 'ddeyes'
import del from 'del'

import gulp from 'gulp'
import gulpSequence from 'gulp-sequence'
import replace from 'gulp-string-replace'
import minify from 'gulp-babel-minify'

import inputJs from './inputJs'
import prettier from './prettier'

import rollup from 'gulp-better-rollup'
import { coffee2 } from 'cfx.rollup-plugin-coffee2'
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
  .pipe gulp.dest './dist'

gulp.task 'dist', =>

  gulp.src './dist/**/*.js'
  .pipe rollup
    plugins: [
      coffee2
        bare: true
        sourceMap: true
      cleanup()
    ]
    , 'iife'
  .pipe replace /\(function \(\) {/g, ''
  .pipe replace /}\(\)\);/g, ''
  .pipe replace /main\(\);/g, ';'
  .pipe prettier()
  # .pipe minify
  #   mangle:
  #     keepClassName: true
  .pipe gulp.dest './dist'

gulp.task 'default'
,
  gulpSequence(
    'clean'
    'build'
    'dist'
  )
