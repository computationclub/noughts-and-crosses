require 'board'

RSpec.describe Board do
  describe '#inspect' do
    it 'represents blank spaces with underscores' do
      expect(Board("___\n___\n___").inspect).to eq("___\n___\n___")
    end
  end

  describe '#place' do
    it 'returns a new board with a move played' do
      board = Board("___\n___\n___")

      expect(board.place('x', 1, 2)).to eq(Board("___\n__x\n___"))
    end
  end

  describe '#full?' do
    it 'returns true if there are no blank places left' do
      board = Board("xox\noxo\nxxo")

      expect(board).to be_full
    end
  end

  describe '#diagonals' do
    it 'returns pieces in both diagonals' do
      board = Board("xox\noxo\nxxo")

      expect(board.diagonals).to contain_exactly(%w(x x o), %w(x x x))
    end
  end

  describe '#columns' do
    it 'returns the pieces in each column' do
      board = Board("xox\noxo\nxxo")

      expect(board.columns).to contain_exactly(%w(x o x), %w(o x x), %w(x o o))
    end
  end

  describe '#next_for' do
    it 'generates all legal next boards for a player' do
      board = Board("oox\n_xo\no_o")

      expect(board.next_for('x')).to contain_exactly(Board("oox\nxxo\no_o"), Board("oox\n_xo\noxo"))
    end
  end
end
