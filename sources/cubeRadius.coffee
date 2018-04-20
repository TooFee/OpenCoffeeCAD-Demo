import c from './index'
import U from './utils'

lwhAndXyz = (lwhxyz) =>
  switch lwhxyz
    when 'l' then 'x'
    when 'w' then 'y'
    when 'h' then 'z'
    when 'x' then 'l'
    when 'y' then 'w'
    when 'z' then 'h'
    else ''

lwhOrXyz = (lwhxyz) =>
  switch lwhxyz
    when 'l' then [ 'w', 'h' ]
    when 'w' then [ 'l', 'h' ]
    when 'h' then [ 'l', 'w' ]
    when 'x' then [ 'y', 'z' ]
    when 'y' then [ 'x', 'z' ]
    when 'z' then [ 'x', 'y' ]
    else []

translateQuadrantRule = (quadrantNo) =>

  return unless typeof quadrantNo is 'number'
  return if quadrantNo < 1
  return if quadrantNo > 4

  _default = [ false, false ]
  switch quadrantNo
    when 1 then _default
    when 2 then [ true, false ]
    when 3 then [ true, true ]
    when 4 then [ false, true ]
    else _default

translateQuadrant = (conf, quadrantNo) =>

  return unless typeof conf is 'object'
  return if ( Object.keys conf ).length isnt 2

  c translateQuadrantRule
  , quadrantNo
  .reduce (rs, cu, id) =>
    key = (
      Object.keys conf
    )[id]
    {
      rs...
      "#{key}":
        if cu
        then - conf[key]
        else conf[key]
    }
  , {}

createBaseRadiusMold = (
  {
    r = 10
    h = 30
  }
  opts = h: 1
) =>
  return if ( typeof opts isnt 'object' )
  return if ( Object.keys opts ).length isnt 1

  lwh = ( Object.keys opts )[0]
  quadrant = opts[lwh]

  baseTranslater =
    x: r / 2 
    y: r / 2

  translater =
    c translateQuadrant
    ,
      baseTranslater
      quadrant

  quarterCube = U.cube {
    l: r
    w: r
    h
  }

  _quarterCube = quarterCube
  .translate translater

  FourCylinde = U.cylinder { r, h }

  outRadius = _quarterCube.difference (
    FourCylinde.intersection _quarterCube
  )

  switch lwh
    when 'l'
      outRadius
      .rotate
        y: 90
      .rotate
        x: 90
    when 'w'
      outRadius
      .rotate
        x: 90
    when 'h'
      outRadius
    else
      outRadius

createRadiusMold = (
  box = {}
  r = 10
  opts
) =>

  return if ( typeof opts isnt 'object' )
  return if ( Object.keys opts ).length isnt 1

  box = {
    {
      l: 100
      w: 50
      h: 30
    }...
    box...
  }

  lwh = ( Object.keys opts )[0]
  quadrant = opts[lwh]

  baseTranslater = (
    lwhOrXyz lwhAndXyz lwh
  ).reduce (rs, cu) =>
    {
      rs...
      "#{cu}": box["#{lwhAndXyz cu}"] / 2 - r
    }
  , {}

  createBaseRadiusMold {
    r
    h: box[lwh]
  }
  , opts
  .translate(
    translateQuadrant baseTranslater
    , quadrant
  )

curryCreateRadiusMold = (box, r) =>

  (opts) => (
    Object.keys opts
  ).reduce (rs, cu) =>

    if Array.isArray opts[cu]

      opts[cu].reduce (_rs, _cu) =>

        _item = c createRadiusMold
        , box, r
        , "#{cu}": _cu

        if _rs?
        then _rs.union _item
        else _item

      , rs

    else if typeof opts[cu] is 'number'

      item = c createRadiusMold
      , box, r
      , "#{cu}": opts[cu]

      if rs?
      then rs.union item
      else item
    
    else rs

  , null

export default (
  {
    l = 100
    w = 50
    h = 30
  }
  r = 10
  opts
) =>
  box = { l, w, h }
  _createRadiusMold =
    curryCreateRadiusMold box, r

  U.cube box 
  .difference _createRadiusMold opts
