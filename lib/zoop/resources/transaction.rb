module Zoop
  class Transaction < Zoop::Model
    alias :charge :create

    def capture
      params = { amount: amount.convert_to_cents, on_behalf_of: on_behalf_of }
      update_model Zoop::Request.post(url('capture'), params: params).run
      self
    end

    def receivables
      Zoop::Request.get( url 'receivables' ).call
    end

    def destroy
      raise NotImplementedError
    end

    class << self
      alias :charge :create
    end
  end
end
