RSpec.describe Zoop::Seller do

  describe '#create' do

    let(:individual_seller) { build :seller, :individual }
    let(:business_seller) { build :seller, :business }
    let(:zoop_response) { { id: 1 } }

    before do
      setup_zoop

      zoop_request = instance_double('Zoop::Request')
      allow(Zoop::Request).to receive(:post).with('/sellers/individuals', params: individual_seller.attributes).and_return(zoop_request)
      allow(Zoop::Request).to receive(:post).with('/sellers/businesses', params: business_seller.attributes).and_return(zoop_request)
      allow(zoop_request).to receive(:run).and_return(zoop_response)
    end

    it 'create an individual seller' do
      seller = individual_seller.create
      expect(seller.id).to eq zoop_response.fetch(:id)
    end

    it 'create a business seller' do
      seller = business_seller.create
      expect(seller.id).to eq zoop_response.fetch(:id)
    end
  end
end
