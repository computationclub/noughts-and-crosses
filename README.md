```ruby
$ irb -Ilib -rboard

>> b = Board('_x_ ___ ___')
=> _x_
   ___
   ___

>> b = b.move_for('o')
=> ox_
   ___
   ___

>> b = b.move_for('x')
=> ox_
   x__
   ___

>> b = b.move_for('o')
=> ox_
   xo_
   ___

>> b = b.move_for('x')
=> ox_
   xo_
   __x

>> b = b.move_for('o')
=> oxo
   xo_
   __x

>> b = b.move_for('x')
=> oxo
   xo_
   x_x

>> b = b.move_for('o')
=> oxo
   xo_
   xox

>> b = b.move_for('x')
=> oxo
   xox
   xox

>> b.draw_for?('x')
=> true


>> b = Board('___ _x_ ___')
=> ___
   _x_
   ___

>> b = b.move_for('o')
=> o__
   _x_
   ___

>> b.rows[0][1] = 'x'; b
=> ox_
   _x_
   ___

>> b = b.move_for('o')
=> ox_
   _x_
   _o_

>> b.rows[2][0] = 'x'; b
=> ox_
   _x_
   xo_

>> b = b.move_for('o')
=> oxo
   _x_
   xo_

>> b.score_for('x')
=> 0


>> b = Board('_o_ _x_ ___')
=> _o_
   _x_
   ___

>> b.score_for('x')
=> 1

>> b.score_for('o')
=> 0

>> b.rows[0][0] = 'x'; b
=> xo_
   _x_
   ___

>> b = b.move_for('o')
=> xoo
   _x_
   ___

>> b.score_for('o')
=> 0

>> b.score_for('x')
=> 1

>> b.win_for?('x')
=> false

>> b = b.move_for('x')
=> xoo
   xx_
   ___

>> b = b.move_for('o')
=> xoo
   xxo
   ___

>> b = b.move_for('x')
=> xoo
   xxo
   x__

>> b.win_for?('x')
=> true
```
