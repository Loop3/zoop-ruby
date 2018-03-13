module Zoop
  class Seller < Zoop::Model

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

    private

    def mount_url
      self.type == 'business' ? 'businesses' : 'individuals'
    end

  end
end
