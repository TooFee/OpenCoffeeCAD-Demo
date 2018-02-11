# title      : Example 001
# author     : OpenSCAD.org, adapted by Rene K. Mueller
# license    : MIT License
# description: example001.scad ported to OpenJSCAD.org
# file       : example001.jscad

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

r_from_dia = (d) => d / 2

rotcy = (rot, r, h) =>
  rotate 90, rot
  ,
    cylinder
      r: r
      h: h
      center: true

example001 = =>
  size = 50
  hole = 25
  cy_r = r_from_dia hole
  cy_h = r_from_dia size * 2.5

  c difference
  , [
    sphere
      r: r_from_dia size
    rotcy [ 0, 0, 0 ], cy_r, cy_h
    rotcy [ 1, 0, 0 ], cy_r, cy_h
    rotcy [ 0, 1, 0 ], cy_r, cy_h
  ]

main = => example001()
