require 'rspec/expectations'
include RSpec::Matchers

class Board
  NOUGHT, CROSS, BLANK = 'o', 'x', '_'

  attr_accessor :rows

  def initialize(rows)
    self.rows = rows
  end

  def ==(other)
    rows == other.rows
  end

  def full?
    !rows.flatten.include?(BLANK)
  end

  def score_for(shape)
    if win_for?(shape)
      1
    elsif lose_for?(shape)
      -1
    elsif draw_for?(shape)
      0
    else
      next_boards = next_for(shape)
      scores = next_boards.map { |board| board.score_for(opponent(shape)) }
      scores.map { |score| -score }.max
    end
  end

  def next_for(shape)
    chars = rows.flatten

    boards = chars.map.with_index do |c, index|
      if c == BLANK
        chars.dup.tap { |chars| chars[index] = shape }
      else
        nil
      end
    end.compact

    boards.map { |board| Board.new(board.each_slice(3).to_a) }
  end

  def inspect
    rows.map { |row| row.join('') }.join("\n")
  end

  def win_for?(shape)
    (rows + rows.transpose).any? { |row| row.uniq == [shape] } ||
      (0...rows.length).map { |n| rows[n][n] }.uniq == [shape] ||
      (0...rows.length).map { |n| rows[n][rows.length - n - 1] }.uniq == [shape]
  end

  def lose_for?(shape)
    win_for?(opponent(shape))
  end

  def draw_for?(shape)
    full? && !(win_for?(shape) || lose_for?(shape))
  end

  def move_for(shape)
    next_for(shape).min_by { |board| board.score_for(opponent(shape)) }
  end

  private

  def opponent(shape)
    ([NOUGHT, CROSS] - [shape]).first
  end
end

def board(string)
  Board.new(string.gsub(/\s/, '').chars.each_slice(3).to_a)
end

expect(board('
             xxx
             xoo
             _o_')).to be_win_for('x')

expect(board(<<~BOARD)).to be_win_for('x')
  xox
  xxo
  oxx
BOARD

expect(board(<<~BOARD)).to be_win_for('x')
  xox
  oxo
  xxo
BOARD

expect(board('
             ooo
             oxx
             _x_')).to be_lose_for('x')

expect(board(<<~BOARD)).to be_draw_for('x')
  oox
  xxo
  oxo
BOARD

expect(board(<<~BOARD)).not_to be_draw_for('x')
  oox
  xxo
  o_o
BOARD

expect(board('
  oox
  _xo
  o_o
').next_for('x')).to contain_exactly \
board('
  oox
  _xo
  oxo
'),
board('
  oox
  xxo
  o_o
')

expect(board('
  oo_
  xx_
  oxo
             ').score_for('x')).to eq 1

expect(board('
  oo_
  xx_
  oxo
             ').score_for('o')).to eq 1

expect(board('
  oo_
  x__
  oxo
             ').score_for('x')).to eq -1

expect(board('
  oo_
  x__
  oxo
             ').score_for('o')).to eq 1

expect(board('
  oo_
  xx_
  oxo
             ').move_for('x')).to eq board('
  oo_
  xxx
  oxo
             ')
