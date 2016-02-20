class Scorer
  attr_reader :board, :current_player
  private :board, :current_player

  def initialize(board, current_player)
    @board = board
    @current_player = current_player
  end

  def score_for(player, maximum = -1, minimum = 1)
    if win_for?(player)
      1
    elsif lose_for?(player)
      -1
    elsif draw?
      0
    elsif next_player == player
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
    horizontal_win_for?(player) || vertical_win_for?(player) || diagonal_win_for?(player)
  end

  def lose_for?(player)
    win_for?(opponent(player))
  end

  def draw?
    board.full? && !(win_for?(current_player) || lose_for?(current_player))
  end

  private

  def next_scorers
    Enumerator.new do |yielder|
      board.next_for(next_player).each do |board|
        yielder << self.class.new(board, next_player)
      end
    end
  end

  def next_player
    opponent(current_player)
  end

  def opponent(player)
    player == 'x'.freeze ? 'o'.freeze : 'x'.freeze
  end

  def horizontal_win_for?(player)
    board.rows.any? { |row| row.uniq == [player] }
  end

  def vertical_win_for?(player)
    board.columns.any? { |column| column.uniq == [player] }
  end

  def diagonal_win_for?(player)
    board.diagonals.any? { |diagonal| diagonal.uniq == [player] }
  end
end
