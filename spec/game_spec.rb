require 'game'
require 'board'

RSpec.describe Game do
  it 'plays a mean game of noughts & crosses' do
    game = described_class.new(Board('___ _x_ ___'), 'o')

    expect { game.play }.to output("o__\n_x_\n___\n").to_stdout
    expect(game.player).to eq('x')
    expect { game.place(0, 1) }.to output("ox_\n_x_\n___\n").to_stdout
    expect(game.player).to eq('o')
    expect { game.play }.to output("ox_\n_x_\n_o_\n").to_stdout
    expect(game.player).to eq('x')
    expect { game.place(2, 0) }.to output("ox_\n_x_\nxo_\n").to_stdout
    expect(game.player).to eq('o')
    expect { game.play }.to output("oxo\n_x_\nxo_\n").to_stdout
  end
end
