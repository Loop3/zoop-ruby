RSpec.describe Zoop::Token do

  describe '.url' do

    it 'return card url when pass number of card' do
      url = Zoop::Token.url('any_card_number')
      expect(url).to eq '/cards/tokens'
    end

    it 'return bank account url when not pass number of card' do
      url = Zoop::Token.url(nil)
      expect(url).to eq '/bank_accounts/tokens'
    end
  end

  describe '#create' do

    let(:zoop_token) { build :card_token }
    let(:zoop_response) { { id: 1 } }

    before do
      setup_zoop

      zoop_request = instance_double('Zoop::Request')
      allow(Zoop::Request).to receive(:post).with('/cards/tokens', params: zoop_token.attributes).and_return(zoop_request)
      allow(zoop_request).to receive(:run).and_return(zoop_response)
    end

    it 'create a zoop token' do
      token = zoop_token.create
      expect(token.id).to eq zoop_response.fetch(:id)
    end
  end
end
