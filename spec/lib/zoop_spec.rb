RSpec.describe Zoop do

  context 'has attribute' do
    it 'api_endpoint' do
      expect(Zoop).to respond_to(:api_endpoint)
    end

    it 'open_timeout' do
      expect(Zoop).to respond_to(:open_timeout)
    end

    it 'timeout' do
      expect(Zoop).to respond_to(:timeout)
    end

    it 'marketplace_id' do
      expect(Zoop).to respond_to(:marketplace_id)
    end

    it 'user_auth' do
      expect(Zoop).to respond_to(:user_auth)
    end

    it 'password_auth' do
      expect(Zoop).to respond_to(:password_auth)
    end
  end
end
