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

  def score_for(shape, maximum_score = -1, minimum_score = 1)
    if win_for?(shape)
      1
    elsif lose_for?(shape)
      -1
    elsif draw?
      0
    else
      if shape == next_shape
        next_boards.inject(-1) do |score, board|
          score = [score, board.score_for(shape, maximum_score, minimum_score)].max
          maximum_score = [maximum_score, score].max
          break score if minimum_score <= maximum_score

          score
        end
      else
        next_boards.inject(1) do |score, board|
          score = [score, board.score_for(shape, maximum_score, minimum_score)].min
          minimum_score = [minimum_score, score].min
          break score if minimum_score <= maximum_score

          score
        end
      end
    end
  end

  def next_boards
    chars = rows.flatten

    Enumerator.new do |yielder|
      chars.each.with_index do |char, index|
        next if char != BLANK

        new_board = chars.dup
        new_board[index] = next_shape

        yielder << Board.new(new_board.each_slice(3).to_a, opponent(next_shape))
      end
    end
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

  def draw?
    full? && !(win_for?(next_shape) || lose_for?(next_shape))
  end

  def next_move
    next_boards.max_by { |board| board.score_for(next_shape) }
  end

  private

  def opponent(shape)
    ([NOUGHT, CROSS] - [shape]).first
  end
end

def Board(string, shape)
  Board.new(string.gsub(/\s/, '').chars.each_slice(3).to_a, shape)
end
