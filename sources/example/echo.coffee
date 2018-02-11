# NOTE: this is merely temporary as the echo() function will likely be deprecated soon
main = =>
  echo 'hi I am outputing some text'

  [
    (
      sphere
        r: 10
        fn: 18
    )
    .translate [
      15
      -25
      0
    ]
  ]
