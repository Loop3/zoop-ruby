module Zoop
  class Token < Zoop::Model

    def create
      @custom_url = self.class.url(self.card_number.present?)
      super
    end

    def destroy
      raise NotImplementedError
    end

    def associate(customer_id)
      raise RequestError.new('Invalid Token ID') unless id.present?
      payment_method.class.associate(customer: customer_id.to_s, token: id.to_s)
    end

    def payment_method
      self.card || self.bank_account
    end

    class << self

      def url(*params)
        case params.first
        when TrueClass then '/cards/tokens'
        when FalseClass then '/bank_accounts/tokens'
        else super(*params)
        end
      end
    end

  end
end
