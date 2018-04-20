import cubeRadius from '../sources/cubeRadius'

export default =>

  box = 
    l: 100
    w: 50
    h: 30

  r = 10

  cubeRadius box, r
  ,
    h: [ 1, 2, 4 ]
    l: 3
    w: [ 3, 4 ]
