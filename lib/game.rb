require 'scorer'

class Game
  attr_reader :board, :player

  def initialize(board, player)
    @board = board
    @player = player
  end

  def place(row, column)
    self.class.new(board.place(player, row, column), player.opponent)
  end

  def play
    self.class.new \
      board.next_for(player).max_by { |board|
        Scorer.new(board, player.opponent).score_for(player)
      },
      player.opponent
  end
end
