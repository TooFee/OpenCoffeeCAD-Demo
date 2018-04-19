Item = (item) ->
  @item = item
  @

Item::isItem = -> true

Item::translate = ({x, y, z}) ->
  @item = translate [ x, y, z ], @item
  @

Item::intersection = (item) ->
  _item =
    if item.isItem()
    then item.getItem()
    else item
  @item = intersection @item, _item
  @

Item::getItem = -> @item

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

export {
  Item
  Cube
  Cylinder
}

export default
  cube: Cube
  cylinder: Cylinder