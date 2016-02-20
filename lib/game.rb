require 'scorer'

class Game
  attr_reader :board, :player

  def initialize(board, player)
    @board = board
    @player = player
  end

  def place(row, column)
    @board = board.place(player, row, column)
    @player = opponent

    puts @board.inspect
  end

  def play
    @board = board.next_for(player).max_by { |board|
      Scorer.new(board, player).score_for(player)
    }
    @player = opponent

    puts @board.inspect
  end

  private

  def opponent
    player == 'x'.freeze ? 'o'.freeze : 'x'.freeze
  end
end
