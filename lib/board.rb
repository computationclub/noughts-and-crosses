require 'player'

class Board
  attr_reader :size, :rows

  def initialize(size, rows)
    @size = size
    @rows = rows
  end

  def place(player, row, column)
    self.class.new size, \
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
    Enumerator.new do |yielder|
      rows.each.with_index do |cells, row|
        cells.each.with_index do |cell, column|
          yielder.yield place(player, row, column) unless cell
        end
      end
    end
  end

  def full?
    rows.flatten.all?
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
    rows.map { |cells| cells.map { |cell| cell ? cell.mark : '_' }.join }.join("\n")
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
  marks = string.gsub(/\s/, '').chars
  size = Math.sqrt(marks.count).to_i
  raise 'board must be square' unless size ** 2 == marks.count

  Board.new(size, marks.map(&Player.method(:for_mark)).each_slice(size).to_a)
end
