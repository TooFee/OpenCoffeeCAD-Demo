# title      : Example 002
# author     : OpenSCAD.org, adapted by Rene K. Mueller
# license    : MIT License
# description: example002.scad ported to OpenJSCAD.org
# file       : example002.jscad

c = (func, params...) =>
  func.apply @, params

c.a = (func, params...) =>
  _params = params.reduce (r, c) =>
    [
      r...
      (
        if Array.isArray c
        then c
        else [ c ]
      )...
    ]
  , []
  c func, _params

example002 = =>

  c intersection
  ,
    c difference
    ,
      c.a union
      , [
        cube
          size: [30, 30, 30]
          center: true
        translate [0, 0, -25]
        ,
          cube
            size: [15, 15, 50]
            center: true
      ]
      c.a union
      , [
        cube
          size: [50, 10, 10]
          center: true
        cube
          size: [10, 50, 10]
          center: true
        cube
          size: [10, 10, 50]
          center: true
      ]
  ,
    translate [0, 0, 5]
    ,
      cylinder
        h: 50
        r1: 20
        r2: 5
        center: true

main = => example002()
