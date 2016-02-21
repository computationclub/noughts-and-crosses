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
    next_games.max_by { |game| Scorer.new(game).score_for(player) }
  end

  def next_games
    board.next_for(player).
      map { |board| self.class.new(board, player.opponent) }
  end
end
