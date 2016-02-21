class Player
  attr_accessor :mark

  def initialize(mark)
    @mark = mark
  end

  X, O = PLAYERS = %w(x o).map(&method(:new))

  def opponent
    PLAYERS.detect(&method(:!=))
  end

  def self.for_mark(mark)
    PLAYERS.detect { |player| player.mark == mark }
  end
end
