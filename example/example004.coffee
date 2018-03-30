# title      : Example 004
# author     : OpenSCAD.org, adapted by Rene K. Mueller
# license    : MIT License
# description: example004.scad ported to OpenJSCAD.org
# file       : example004.jscad

import c from '../sources'

export default =>

  c difference
  ,
    cube
      size: 30
      center: true
  ,
    sphere 20
