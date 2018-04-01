import c from '../sources'

export default =>
  c union
  ,
    c difference
    ,
      cube
        size: 3
        center: true
      sphere
        r:2
        center: true
    c intersection
    ,
      sphere
        r: 1.3
        center: true
      cube
        size: 2.1
        center: true
  .translate [ 0, 0, 1.5 ]
  .scale 10
