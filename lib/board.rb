class Board
  attr_reader :rows

  def initialize(rows)
    @rows = rows
  end

  def place(player, row, column)
    self.class.new \
      rows.map.with_index { |cells, row_index|
        cells.map.with_index { |cell, column_index|
          if [row_index, column_index] == [row, column]
            player
          else
            cell
          end
        }
      }
  end

  def next_for(player)
    places = rows.flatten

    Enumerator.new do |yielder|
      places.each.with_index do |place, index|
        next if place != '_'.freeze

        new_board = places.dup
        new_board[index] = player

        yielder << self.class.new(new_board.each_slice(3).to_a)
      end
    end
  end

  def full?
    !rows.flatten.include?('_'.freeze)
  end

  def columns
    rows.transpose
  end

  def diagonals
    [left_right_diagonal, right_left_diagonal]
  end

  def ==(other)
    rows == other.rows
  end

  def inspect
    rows.map(&:join).join("\n")
  end

  private

  def left_right_diagonal
    (0...rows.length).map { |n| rows[n][n] }
  end

  def right_left_diagonal
    (0...rows.length).map { |n| rows[n][rows.length - n - 1] }
  end
end

def Board(string)
  Board.new(string.gsub(/\s/, '').chars.each_slice(3).to_a)
end
