c = (func, params...) ->
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

export default c
