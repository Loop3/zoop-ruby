RSpec.describe Zoop::Transaction do

  describe '#destroy' do

    let(:transaction) { build :transaction }

    it 'raise error when try destroy' do
      expect { transaction.destroy }.to raise_error(NotImplementedError)
    end
  end

end