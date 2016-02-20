require 'scorer'
require 'board'

class Game
  attr_accessor :board, :player

  def initialize(board, player)
    self.board = board
    self.player = player
  end

  def place(row, column)
    self.board = board.place(player, row, column)
    self.player = opponent

    board
  end

  def play
    self.board = board.next_for(player).max_by { |board|
      Scorer.new(board, player).score_for(player)
    }
    self.player = opponent

    board
  end

  private

  def opponent
    player == 'x'.freeze ? 'o'.freeze : 'x'.freeze
  end
end
