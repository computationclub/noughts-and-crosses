```ruby
$ irb -Ilib -rboard

>> b = Board('_x_ ___ ___', 'o')
=> _x_
   ___
   ___

>> b = b.next_move
=> ox_
   ___
   ___

>> b = b.next_move
=> ox_
   x__
   ___

>> b = b.next_move
=> ox_
   xo_
   ___

>> b = b.next_move
=> ox_
   xo_
   __x

>> b = b.next_move
=> oxo
   xo_
   __x

>> b = b.next_move
=> oxo
   xo_
   x_x

>> b = b.next_move
=> oxo
   xo_
   xox

>> b = b.next_move
=> oxo
   xox
   xox

>> b.draw?
=> true


>> b = Board('___ _x_ ___', 'o')
=> ___
   _x_
   ___

>> b = b.next_move
=> o__
   _x_
   ___

>> b.rows[0][1] = 'x'; b.next_shape = 'o'; b
=> ox_
   _x_
   ___

>> b = b.next_move
=> ox_
   _x_
   _o_

>> b.rows[2][0] = 'x'; b.next_shape = 'o'; b
=> ox_
   _x_
   xo_

>> b = b.next_move
=> oxo
   _x_
   xo_

>> b.score_for('x')
=> 0


>> b = Board('_o_ _x_ ___', 'x')
=> _o_
   _x_
   ___

>> b.score_for('x')
=> 1

>> b.score_for('o')
=> 0

>> b.rows[0][0] = 'x'; b.next_shape = 'o'; b
=> xo_
   _x_
   ___

>> b = b.next_move
=> xoo
   _x_
   ___

>> b.score_for('o')
=> -1

>> b.score_for('x')
=> 1

>> b.win_for?('x')
=> false

>> b = b.next_move
=> xoo
   xx_
   ___

>> b = b.next_move
=> xoo
   xxo
   ___

>> b = b.next_move
=> xoo
   xxo
   x__

>> b.win_for?('x')
=> true
```
