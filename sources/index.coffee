c = (func, params...) ->
  func.apply @, params

export default c
