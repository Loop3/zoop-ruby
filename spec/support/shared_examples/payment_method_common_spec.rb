RSpec.shared_examples 'payment method' do

  describe '#create' do

    context 'when attr token has present in payment method' do

      let(:association_payment_method) do
        described_class == Zoop::Card ? build(:association_card_with_customer) :  build(:association_bank_account_with_customer)
      end

      let(:zoop_response) do
        if described_class == Zoop::Card
          build(:card, :created).attributes
        else
          build(:bank_account, :individual, :created).attributes
        end
      end

      before do
        zoop_request = instance_double('Zoop::Request')
        allow(Zoop::Request).to receive(:post).with("/#{described_class.class_name.underscore}s", params: association_payment_method.attributes).and_return(zoop_request)
        allow(zoop_request).to receive(:run).and_return(zoop_response)
      end

      it 'associate payment method to customer' do
        payment_method = association_payment_method.create
        expect(payment_method.attributes).to eq(zoop_response)
      end
    end

    context 'when not exists attr token in payment method' do

      let(:payment_method) do
        described_class == Zoop::Card ? build(:card) : build(:bank_account, :individual)
      end

      let(:zoop_response) do
        if described_class == Zoop::Card
          build(:card_token, :created)
        else
          build(:bank_account_token, :individual, :created_individual)
        end
      end

      before do
        zoop_request = instance_double('Zoop::Request')
        allow(Zoop::Request).to receive(:post).with("/#{described_class.class_name.underscore}s/tokens", params: payment_method.attributes).and_return(zoop_request)
        allow(zoop_request).to receive(:run).and_return(zoop_response.attributes)
      end

      it 'create a payment method' do
        payment_method = self.payment_method.create
        expect(payment_method.attributes).to eq(zoop_response.payment_method.attributes)
      end

      it 'add token attr in payment method' do
        payment_method = self.payment_method.create
        expect(payment_method.token).to eq(zoop_response.id)
      end
    end
  end

  describe '#associate' do

    let(:customer_id) { '1' }
    let(:token_id) { '2' }
    let(:payment_method) do
      if described_class == Zoop::Card
        build(:card, :created, token: token_id)
      else
        build(:bank_account, :individual, :created, token: token_id)
      end
    end

    let(:payment_method_with_costumer) { payment_method.customer = customer_id; payment_method }

    before do
      allow(described_class).to receive(:associate).with(customer: customer_id, token: payment_method.token).and_return(payment_method_with_costumer)
    end

    it 'raise error when token not present' do
      payment_method.token = nil
      expect { payment_method.associate(customer_id) }.to raise_error(Zoop::RequestError)
    end

    it 'associate with customer' do
      payment_method = self.payment_method.associate(customer_id)
      expect(payment_method.customer).to eq(customer_id)
    end
  end

end