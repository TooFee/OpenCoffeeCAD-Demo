Item = (item) ->
  @item = item
  @

Item::isItem = -> true
Item::getItem = -> @item

Item::translate = ({
  x = 0
  y = 0
  z = 0
}) ->
  new Item translate [ x, y, z ], @item

Item::mirror = ({
  x = 0
  y = 0
  z = 0
}) ->
  new Item mirror [ x, y, z ], @item

Item::rotate = ({
  x = 0
  y = 0
  z = 0
}) ->
  new Item rotate [ x, y, z ], @item

getRealItems = (items) =>
  items.reduce (r, c) =>
    [
      r...
      if c.isItem()
      then c.getItem()
      else c
    ]
  , []

itemCallitems = (item, func, items) =>
  new Item func.apply null
  , [
    item
    ( getRealItems items )...
  ]

Item::union = (items...) ->
  itemCallitems @item
  , union, items

Item::intersection = (items...) ->
  itemCallitems @item
  , intersection, items

Item::difference = (items...) ->
  itemCallitems @item
  , difference, items

export default Item
