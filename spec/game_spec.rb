require 'game'
require 'board'

RSpec.describe Game do
  it 'plays a mean game of noughts & crosses' do
    game = described_class.new(Board('___ _x_ ___'), 'o')

    expect(game.play).to eq(Board('o__ _x_ ___'))
    expect(game.player).to eq('x')
    expect(game.place(0, 1)).to eq(Board('ox_ _x_ ___'))
    expect(game.player).to eq('o')
    expect(game.play).to eq(Board('ox_ _x_ _o_'))
    expect(game.player).to eq('x')
    expect(game.place(2, 0)).to eq(Board('ox_ _x_ xo_'))
    expect(game.player).to eq('o')
    expect(game.play).to eq(Board('oxo _x_ xo_'))
  end
end
