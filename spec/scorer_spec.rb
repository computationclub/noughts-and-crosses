require 'scorer'
require 'board'

RSpec.describe Scorer do
  describe '#win_for?' do
    it 'detects horizontal wins for a player' do
      scorer = described_class.new(Board("xxx\noo_\n___"), 'x')

      expect(scorer).to be_win_for('x')
    end

    it 'detects vertical wins for a player' do
      scorer = described_class.new(Board("xo_\nxo_\nx__"), 'x')

      expect(scorer).to be_win_for('x')
    end

    it 'detects left-right diagonal wins for a player' do
      scorer = described_class.new(Board("xo_\nox_\n__x"), 'x')

      expect(scorer).to be_win_for('x')
    end

    it 'detects right-left diagonal wins for a player' do
      scorer = described_class.new(Board("_ox\nox_\nx__"), 'x')

      expect(scorer).to be_win_for('x')
    end
  end

  describe '#lose_for?' do
    it 'is true when the opponent wins' do
      scorer = described_class.new(Board("_ox\nox_\nx__"), 'o')

      expect(scorer).to be_lose_for('o')
    end
  end

  describe '#draw?' do
    it 'is true when neither player wins and the board is full' do
      scorer = described_class.new(Board("oox\nxxo\noxo"), 'x')

      expect(scorer).to be_draw
    end

    it 'is false if the board is not full' do
      scorer = described_class.new(Board("oox\nxxo\nox_"), 'x')

      expect(scorer).not_to be_draw
    end
  end

  describe '#score_for' do
    it 'returns 1 for a win' do
      scorer = described_class.new(Board("xxx\noo_\n___"), 'x')

      expect(scorer.score_for('x')).to eq(1)
    end

    it 'returns -1 for a loss' do
      scorer = described_class.new(Board("xxx\noo_\n___"), 'x')

      expect(scorer.score_for('o')).to eq(-1)
    end

    it 'returns 0 for a draw' do
      scorer = described_class.new(Board("oox\nxxo\noxo"), 'o')

      expect(scorer.score_for('x')).to eq(0)
    end

    it 'returns 1 for a win in the next move' do
      scorer = described_class.new(Board("xx_\noo_\n___"), 'x')

      expect(scorer.score_for('o')).to eq(1)
    end

    it 'returns -1 for a lose on the next move' do
      scorer = described_class.new(Board("xx_\noo_\n___"), 'x')

      expect(scorer.score_for('x')).to eq(-1)
    end
  end
end
