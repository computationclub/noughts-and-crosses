require 'game'
require 'board'

RSpec.describe Game do
  it 'plays a mean game of noughts & crosses' do
    game = described_class.new(Board('___ _x_ ___'), 'o')

    game = game.play
    expect(game.board).to eq(Board('o__ _x_ ___'))
    expect(game.player).to eq('x')

    game = game.place(0, 1)
    expect(game.board).to eq(Board('ox_ _x_ ___'))
    expect(game.player).to eq('o')

    game = game.play
    expect(game.board).to eq(Board('ox_ _x_ _o_'))
    expect(game.player).to eq('x')

    game = game.place(2, 0)
    expect(game.board).to eq(Board('ox_ _x_ xo_'))
    expect(game.player).to eq('o')

    game = game.play
    expect(game.board).to eq(Board('oxo _x_ xo_'))
    expect(game.player).to eq('x')
  end
end
