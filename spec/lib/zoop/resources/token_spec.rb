RSpec.describe Zoop::Token do

  describe '.url' do

    it 'return card url when pass true' do
      url = Zoop::Token.url(true)
      expect(url).to eq '/cards/tokens'
    end

    it 'return bank account url when pass false' do
      url = Zoop::Token.url(false)
      expect(url).to eq '/bank_accounts/tokens'
    end

    it 'return custom when pass a string' do
      url = Zoop::Token.url('test')
      expect(url).to eq '/tokens/test'
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

  describe '#destroy' do

    let(:card_token) { build :card_token }

    it 'raise error when try destroy' do
      expect { card_token.destroy }.to raise_error(NotImplementedError)
    end
  end

  describe '#associate' do

    let(:card_token) { build :card_token, :created }
    let(:bank_account_token) { build :bank_account_token, :individual, :created_individual }
    let(:customer_id) { '1' }

    before do
      allow(Zoop::Card).to receive(:associate).with(customer: customer_id, token: card_token.id).and_return(card_token.card)
      allow(Zoop::BankAccount).to receive(:associate).with(customer: customer_id, token: bank_account_token.id).and_return(bank_account_token.bank_account)
    end

    it 'raise error when try associate a token not created yet' do
      card_token.id = nil
      expect { card_token.associate(customer_id) }.to raise_error(Zoop::RequestError)
    end

    it 'with card token' do
      card = card_token.associate(customer_id)
      expect(card).to eq(card_token.card)
    end

    it 'with bank account token' do
      bank_account = bank_account_token.associate(customer_id)
      expect(bank_account).to eq(bank_account_token.bank_account)
    end
  end
end
