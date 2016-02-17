class Board
  NOUGHT, CROSS, BLANK = 'o', 'x', '_'

  attr_accessor :rows, :next_shape

  def initialize(rows, next_shape)
    self.rows = rows
    self.next_shape = next_shape
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
      next_boards = next_boards_for(shape)
      scores = next_boards.map { |board| board.score_for(opponent(shape)) }
      scores.map { |score| -score }.max
    end
  end

  def next_boards_for(shape)
    chars = rows.flatten

    boards = chars.map.with_index do |c, index|
      if c == BLANK
        chars.dup.tap { |chars| chars[index] = shape }
      else
        nil
      end
    end.compact

    boards.map { |board| Board.new(board.each_slice(3).to_a, opponent(shape)) }
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

  def next_move_for(shape)
    next_boards_for(shape).min_by { |board| board.score_for(opponent(shape)) }
  end

  private

  def opponent(shape)
    ([NOUGHT, CROSS] - [shape]).first
  end
end

def Board(string, shape)
  Board.new(string.gsub(/\s/, '').chars.each_slice(3).to_a, shape)
end
