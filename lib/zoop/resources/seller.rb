module Zoop
  class Seller < Zoop::Model

    def create
      @custom_url = self.class.url(mount_url)
      super
    end

    private

    def mount_url
      self.type == 'business' ? 'businesses' : 'individuals'
    end

  end
end
