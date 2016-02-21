require 'scorer'
require 'board'

class Game
  PLAYERS = 'x'.freeze, 'o'.freeze

  attr_reader :board, :player

  def initialize(board, player)
    @board = board
    @player = player
  end

  def place(row, column)
    self.class.new(board.place(player, row, column), opponent)
  end

  def play
    self.class.new \
      board.next_for(player).max_by { |board|
        Scorer.new(board, player).score_for(player)
      },
      opponent
  end

  private

  def opponent
    PLAYERS.detect(&player.method(:!=))
  end
end
