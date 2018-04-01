# title      : Example 005
# author     : OpenSCAD.org, adapted by Rene K. Mueller
# license    : MIT License
# description: example005.scad ported to OpenJSCAD
# file       : example005.jscad

import c from '../sources'

example005 = =>

  cy = [1..5].reduce (r, c) =>
    # echo(
    #   360*i/6
    #   sin(360*i/6)*80
    #   cos(360*i/6)*80
    # )
    [
      r...
      translate [
        sin(360*c/6)*80
        cos(360*c/6)*80
        0
      ]
      ,
        cylinder
          h: 200
          r: 10
    ]
  , []

  c translate
  , [0, 0, -120]
  ,
    c union
    ,
      c difference
      ,
        cylinder
          h: 50
          r: 100
        translate [0, 0, 10]
        ,
          cylinder
            h: 50
            r: 80
        translate [100, 0, 35]
        ,
          cube
            size: 50
            center: true
    , cy
    ,
      translate [0, 0, 200]
      ,
        cylinder
          h: 80
          r1: 120
          r2: 0

export default =>
  example005()
  .scale 1/3
