require 'Board'

RSpec.describe Board do
  describe '#win_for?' do
    it 'detects horizontal wins' do
      expect(Board(<<-BOARD, 'x')).to be_win_for('x')
        xxx
        xoo
        _o_
      BOARD
    end

    it 'detects diagonal wins from top-left to bottom-right' do
      expect(Board(<<-BOARD, 'x')).to be_win_for('x')
        xox
        xxo
        oxx
      BOARD
    end

    it 'detects diagonal wins from top-right to bottom-left' do
      expect(Board(<<-BOARD, 'x')).to be_win_for('x')
        xox
        oxo
        xxo
      BOARD
    end
  end

  describe '#lose_for?' do
    it 'is true when the opponent wins' do
      expect(Board(<<-BOARD, 'x')).to be_lose_for('x')
        ooo
        oxx
        _x_
      BOARD
    end
  end

  describe '#draw?' do
    it 'is true when neither player wins and the Board is full' do
      expect(Board(<<-BOARD, 'x')).to be_draw
        oox
        xxo
        oxo
      BOARD
    end

    it 'is false if the Board is not full' do
      expect(Board(<<-BOARD, 'x')).not_to be_draw
        oox
        xxo
        o_o
      BOARD
    end
  end

  describe '#next_boards' do
    it 'generates all possible next moves' do
      expect(Board(<<-BOARD, 'x').next_boards).to contain_exactly(Board(<<-BOARD2, 'o'), Board(<<-BOARD3, 'o'))
        oox
        _xo
        o_o
      BOARD
        oox
        _xo
        oxo
      BOARD2
        oox
        xxo
        o_o
      BOARD3
    end
  end

  describe '#score_for' do
    it 'returns 1 for a win' do
      expect(Board(<<-BOARD, 'x').score_for('x')).to eq(1)
        oo_
        xx_
        oxo
      BOARD
    end

    it 'returns 1 for a win on the next move' do
      expect(Board(<<-BOARD, 'o').score_for('o')).to eq(1)
        oo_
        xx_
        oxo
      BOARD
    end

    it 'returns -1 for a loss on the next move' do
      expect(Board(<<-BOARD, 'x').score_for('x')).to eq(-1)
        oo_
        x__
        oxo
      BOARD
    end

    it 'returns 1 for a win two moves ahead' do
      expect(Board(<<-BOARD, 'o').score_for('o')).to eq(1)
        oo_
        x__
        oxo
      BOARD
    end
  end

  describe '#next_move' do
    it 'chooses the best next move' do
      expect(Board(<<-BOARD, 'x').next_move).to eq Board(<<-BOARD2, 'o')
        oo_
        xx_
        oxo
      BOARD
        oo_
        xxx
        oxo
      BOARD2
    end

    it 'chooses the best move on an empty board' do
      expect(Board(<<-BOARD, 'x').next_move).to eq Board(<<-BOARD2, 'o')
        ___
        ___
        ___
      BOARD
        x__
        ___
        ___
      BOARD2
    end
  end
end
