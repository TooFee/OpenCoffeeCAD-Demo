import Item from './Item'

Cube = (
  {l, w, h}
  center = true
) =>
  new Item cube {
    size: [ l, w, h ]
    center
  }

Cylinder = (
  {r, h}
  center = true
) =>
  new Item cylinder {
    r, h
    center
  }

Sphere = (
  { r }
  center = true
) =>
  new Item sphere {
    r
    center
  }

export {
  Item
  Cube
  Cylinder
  Sphere
}

export default
  cube: Cube
  cylinder: Cylinder
  sphere: Sphere
