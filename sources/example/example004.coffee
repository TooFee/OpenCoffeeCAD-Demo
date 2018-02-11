# title      : Example 004
# author     : OpenSCAD.org, adapted by Rene K. Mueller
# license    : MIT License
# description: example004.scad ported to OpenJSCAD.org
# file       : example004.jscad

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

example004 = =>
  c difference
  ,
    cube
      size: 30
      center: true
  ,
    sphere 20

main = => example004()
