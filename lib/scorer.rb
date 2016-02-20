class Scorer
  attr_reader :board, :current_player
  private :board, :current_player

  def initialize(board, current_player)
    @board = board
    @current_player = current_player
  end

  def score_for(player)
    if win_for?(player)
      1
    elsif lose_for?(player)
      -1
    elsif draw?
      0
    else
      scores = board.next_for(next_player).map { |board|
        self.class.new(board, next_player).score_for(player)
      }

      if next_player == player
        scores.max
      else
        scores.min
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
