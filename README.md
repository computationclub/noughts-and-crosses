```ruby
$ irb -Ilib -rgame

game = Game.new(Board('___ ___ ___'), 'x')
game.place(0, 0)
=> x__
   ___
   ___
game.play
=> xo_
   ___
   ___
