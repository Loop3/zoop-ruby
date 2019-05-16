module Zoop
  class BankAccount < Zoop::PaymentMethodCommon
    def transfer(params={})
      Zoop::Request.post(url('transfers'), params: params).call
    end
  end
end
