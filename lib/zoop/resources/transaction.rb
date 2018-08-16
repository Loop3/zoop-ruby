module Zoop
  class Transaction < Zoop::Model
    alias :charge :create

    def initialize(response = {})
      super(response)

      self.currency         ||= 'BRL'
      self.payment_type     ||= 'credit'
      self.capture          ||= true
    end

    def capture!
      params = { amount: amount.convert_to_cents, on_behalf_of: on_behalf_of }
      update_model Zoop::Request.post(url('capture'), params: params).run
      self
    end

    def refund
      params = { amount: amount.convert_to_cents, on_behalf_of: on_behalf_of }
      update_model Zoop::Request.post(url('void'), params: params).run
      self
    end

    def receivables
      Zoop::Request.get( url 'receivables' ).call
    end

    def split_rules
      Zoop::Request.get( url 'split_rules' ).call
    end

    def destroy
      raise NotImplementedError
    end

    class << self
      alias :charge :create
    end
  end
end
