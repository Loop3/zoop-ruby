module Zoop
  class PaymentMethodCommon < Model

    def create
      return super if self.token.present?

      token = Zoop::Token.create(to_hash)
      token.payment_method.token = token.id
      token.payment_method
    end

    def associate(customer_id)
      raise RequestError.new('Invalid Token ID') unless token.present?
      self.class.associate(customer: customer_id.to_s, token: token.to_s)
    end

    class << self
      alias :associate :create
    end
  end
end
