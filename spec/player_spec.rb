require 'player'

RSpec.describe Player do
  describe '#mark' do
    specify { expect(X.mark).to eq 'x' }
    specify { expect(O.mark).to eq 'o' }
  end

  describe '#opponent' do
    specify { expect(X.opponent).to eq O }
    specify { expect(O.opponent).to eq X }
  end

  describe '.form_mark' do
    specify { expect(Player.for_mark('x')).to eq X }
    specify { expect(Player.for_mark('o')).to eq O }
    specify { expect(Player.for_mark('_')).to be_nil }
  end
end
