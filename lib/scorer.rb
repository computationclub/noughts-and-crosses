class Scorer
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def score_for(player, maximum = -1, minimum = 1)
    if win_for?(player)
      1
    elsif lose_for?(player)
      -1
    elsif draw?
      0
    elsif game.player == player
      next_scorers.inject(-1) do |score, scorer|
        score = [score, scorer.score_for(player, maximum, minimum)].max
        maximum = [maximum, score].max
        break score if minimum <= maximum

        score
      end
    else
      next_scorers.inject(1) do |score, scorer|
        score = [score, scorer.score_for(player, maximum, minimum)].min
        minimum = [minimum, score].min
        break score if minimum <= maximum

        score
      end
    end
  end

  def win_for?(player)
    [:rows, :columns, :diagonals].any? { |method|
      game.board.send(method).any? { |cells|
        cells.all?(&player.method(:==))
      }
    }
  end

  def lose_for?(player)
    win_for?(player.opponent)
  end

  def draw?
    game.board.full? && !(win_for?(game.player) || lose_for?(game.player))
  end

  private

  def next_scorers
    Enumerator.new do |yielder|
      game.board.next_for(game.player).each do |board|
        yielder << self.class.new(Game.new(board, game.player.opponent))
      end
    end
  end
end
