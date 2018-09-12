module Zoop
  class Seller < Zoop::CustomerCommon

    def create
      @custom_url = self.class.url(mount_url)
      super
    end

    def update(params={})
      raise RequestError.new('Invalid ID') unless id.present?
      @custom_url = self.class.url(mount_url, CGI.escape(id.to_s))
      super
    end

    def save
      raise RequestError.new('Invalid ID') unless id.present?
      @custom_url = self.class.url(mount_url, CGI.escape(id.to_s))
      super
    end

    def receiving_policy
      Zoop::Request.get(url 'receiving_policy').call
    end

    def update_receiving_policy(params={})
      Zoop::Request.post(url('receiving_policy'), params: params).call
    end

    def documents
      Zoop::Request.get( url 'documents' ).call
    end

    def upload_documents(params={})
      Zoop::Request.post(url('documents'), params: params).call
    end

    def bank_accounts
      Zoop::Request.get( url 'bank_accounts' ).call
    end

    def transactions
      Zoop::Request.get(url('transactions'), headers: { 'Content-Type' => '' }).call
    end

    private

    def mount_url
      self.type == 'business' ? 'businesses' : 'individuals'
    end

  end
end
